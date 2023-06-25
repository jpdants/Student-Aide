import 'package:flutter/material.dart';
import 'package:trabalho_final_prog_moveis/view/tela_home.dart';

class PreencherCardTela extends StatefulWidget {
  final void Function(Map<String, dynamic>) adicionarAnotacao;

  const PreencherCardTela({required this.adicionarAnotacao});

  @override
  _PreencherCardTelaState createState() => _PreencherCardTelaState();
}

class _PreencherCardTelaState extends State<PreencherCardTela> {
  String selectedDiscipline = 'Matemática';
  TextEditingController annotationController = TextEditingController();
  DateTime dataCriacao = DateTime.now();

  void saveAnnotation() {
    String discipline = selectedDiscipline;
    String annotation = annotationController.text;
    String createdAt = dataCriacao.toIso8601String();

    Map<String, dynamic> anotacao = {
      'discipline': discipline,
      'annotation': annotation,
      'created_at': createdAt,
    };

    widget.adicionarAnotacao(anotacao);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Substitui a rota atual pela HomePage
    );
  }

  @override
  void dispose() {
    annotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preencher Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedDiscipline,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDiscipline = newValue!;
                });
              },
              items: <String>[
                'Matemática',
                'História',
                'Geografia',
                'Ciências',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: annotationController,
              decoration: const InputDecoration(
                labelText: 'Anotação',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveAnnotation,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
