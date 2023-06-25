import 'package:flutter/material.dart';

class PreencherCardTela extends StatefulWidget {
  @override
  _PreencherCardTelaState createState() => _PreencherCardTelaState();
}

class _PreencherCardTelaState extends State<PreencherCardTela> {
  String selectedDiscipline = 'Matemática';
  TextEditingController annotationController = TextEditingController();
  DateTime dataCriacao = DateTime.now(); // Data de criação como um objeto DateTime

  void saveAnnotation() {
    String discipline = selectedDiscipline;
    String annotation = annotationController.text;
    String createdAt = dataCriacao.toIso8601String(); // Converter a data para uma string no formato ISO 8601

    Map<String, dynamic> anotacao = {
      'discipline': discipline,
      'annotation': annotation,
      'created_at': createdAt, // Usar a string de data de criação
    };

    Navigator.pop(context, anotacao); // Retornar a anotação como resultado
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
                // Adicione as disciplinas desejadas aqui
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

