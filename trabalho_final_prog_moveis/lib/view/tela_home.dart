import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/botton_add_notacao.dart';
import '../components/tag_classificacao.dart';
import '../constants/app_colors.dart';
import '../model/preencher_card_tela.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> anotacoes = [];

  String? selectedTag;

  void adicionarAnotacao(Map<String, dynamic> anotacao) {
    setState(() {
      anotacoes.add(anotacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tagList =
        anotacoes.map((anotacao) => anotacao['discipline']).toSet().toList();

    Map<String, List<Map<String, dynamic>>> tagLists = {};

    // Generate tag-specific lists
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
                          builder: (context) => const PreencherCardTela(),
                        ),
                      );

                      if (result != null) {
                        adicionarAnotacao(result);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton(
                hint: const Text('Selecione uma disciplina'),
                value: selectedTag,
                items: tagList.map((tag) {
                  return DropdownMenuItem(
                    value: tag,
                    child: Text(tag),
                  );
                }).toList(),
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: tagAnotacoes?.length,
                          itemBuilder: (context, index) {
                            final anotacao = tagAnotacoes?[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: AnotacaoWidget(
                                descricao: anotacao?['annotation'],
                                dataCriacao: anotacao?['dataCriacao'],
                                tags: [anotacao?['discipline']],
                              ),
                            );
                          },
                        ),
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