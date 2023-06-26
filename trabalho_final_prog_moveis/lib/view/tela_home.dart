import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../components/widget_anotacao.dart';
import 'preencher_card_tela.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database _database;
  List<Map<String, dynamic>> anotacoes = [];
  String? selectedTag;
  late Map<String, List<Map<String, dynamic>>> tagLists;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String databasePath = path.join(appDirectory.path, 'notes.db');
    _database = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, discipline TEXT, annotation TEXT, created_at TEXT)');
    });

    await _loadAnotacoes();
  }

  Future<void> _loadAnotacoes() async {
    final List<Map<String, dynamic>> anotacoes = await _database.query('notes');
    setState(() {
      this.anotacoes = anotacoes;
    });
  }

  Future<void> _adicionarAnotacao(Map<String, dynamic> anotacao) async {
    final int insertedId = await _database.insert('notes', anotacao);

    final Map<String, dynamic> newAnotacao = {
      'id': insertedId,
      'discipline': anotacao['discipline'],
      'annotation': anotacao['annotation'],
      'created_at': anotacao['created_at'],
    };

    setState(() {
      anotacoes.add(newAnotacao);
    });
  }

  Future<void> _removerAnotacao(int id) async {
    await _database.delete('notes', where: 'id = ?', whereArgs: [id]);

    setState(() {
      anotacoes.removeWhere((anotacao) => anotacao['id'] == id);
    });
  }

  Future<bool?> _exibirDialogoConfirmacao(int id) {
    final completer = Completer<bool?>();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir esta anotação permanentemente?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                completer.complete(false);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                completer.complete(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  Future<void> _editarAnotacao(Map<String, dynamic> anotacao) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreencherCardTela(
          adicionarAnotacao: _adicionarAnotacao,
          editarAnotacao: (anotacaoEditada, adicionarAnotacao) {
            _removerAnotacao(anotacao['id']);
            adicionarAnotacao(anotacaoEditada);
          },
          anotacao: anotacao,
        ),
      ),
    );

    if (result != null) {
      _adicionarAnotacao(result);
    }

    _loadAnotacoes(); // Atualiza a lista de anotações após a edição
  }

  @override
  Widget build(BuildContext context) {
    final tagList =
        anotacoes.map((anotacao) => anotacao['discipline']).toSet().toList();

    tagLists = {};

    anotacoes.forEach((anotacao) {
      if (tagLists[anotacao['discipline']] == null) {
        tagLists[anotacao['discipline']] = [];
      }
      tagLists[anotacao['discipline']]?.add(anotacao);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Sua Tela'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              AddPlanWidget(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreencherCardTela(
                        adicionarAnotacao: (Map<String, dynamic> anotacao) {
                          _adicionarAnotacao(anotacao);
                        },
                        editarAnotacao: (anotacaoEditada, adicionarAnotacao) {
                          // Lógica para editar a anotação
                        },
                      ),
                    ),
                  );

                  if (result != null) {
                    _adicionarAnotacao(result);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                hint: const Text('Selecione uma disciplina'),
                value: selectedTag,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: null,
                    child: const Text('Todas as disciplinas'),
                  ),
                  ...tagList.map((tag) {
                    return DropdownMenuItem<String>(
                      value: tag,
                      child: Text(tag),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTag = value;
                  });
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: 252,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: tagLists.keys.length,
                  itemBuilder: (context, index) {
                    final tag = tagLists.keys.toList()[index];
                    final tagAnotacoes = tagLists[tag];
                    if (selectedTag != null && selectedTag != tag) {
                      return Container();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            tag,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        ...tagAnotacoes!.map((anotacao) {
                          return Dismissible(
                            key: Key(anotacao['id'].toString()),
                            confirmDismiss: (_) async {
                              return await _exibirDialogoConfirmacao(
                                  anotacao['id']);
                            },
                            background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                            onDismissed: (_) {
                              // Remova este trecho, pois você já está chamando o método _exibirDialogoConfirmacao no confirmDismiss.
                              // await _exibirDialogoConfirmacao(anotacao['id']);
                            },
                            child: GestureDetector(
                              onTap: () {
                                _editarAnotacao(anotacao);
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                child: ListTile(
                                  title: Text(
                                    anotacao['annotation'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(anotacao['created_at']),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
