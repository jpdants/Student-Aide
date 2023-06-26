import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../components/botton_add_notacao.dart';
import '../components/tag_classificacao.dart';
import '../constants/app_colors.dart';
import 'preencher_card_tela.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database _database;
  List<Map<String, dynamic>> anotacoes = [];

  String? selectedTag;

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

  @override
  Widget build(BuildContext context) {
    final tagList =
        anotacoes.map((anotacao) => anotacao['discipline']).toSet().toList();

    Map<String, List<Map<String, dynamic>>> tagLists = {};

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
              Container(
                width: 252,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.kSecondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 70.0,
                    right: 70.0,
                    bottom: 25,
                    top: 25,
                  ),
                  child: AddPlanWidget(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreencherCardTela(),
                        ),
                      );

                      if (result != null) {
                        _adicionarAnotacao(result);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton(
                hint: const Text('Selecione uma disciplina'),
                value: selectedTag,
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    value: null,
                    child: const Text('Todas as disciplinas'),
                  ),
                  ...tagList.map((tag) {
                    return DropdownMenuItem(
                      value: tag,
                      child: Text(tag),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTag = value as String?;
                  });
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height *
                    0.6, // Define a altura desejada (por exemplo, 60% da altura da tela)
                width: 252,
                child: ListView.builder(
                  shrinkWrap:
                      true, // Ajusta o tamanho do ListView.builder ao seu conteúdo
                  scrollDirection: Axis.vertical,
                  itemCount: tagLists.keys.length,
                  itemBuilder: (context, index) {
                    final tag = tagLists.keys.toList()[index];
                    final tagAnotacoes = tagLists[tag];
                    if (selectedTag != null && selectedTag != tag) {
                      return Container(); // Retorna uma pequena faixa vazia quando a tag selecionada for diferente da tag atual
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
                          return Card(
                            child: ListTile(
                              title: Text(anotacao['annotation']),
                              subtitle: Text(anotacao['created_at']),
                            ),
                          );
                        }).toList(),
                        const Divider()
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
