import 'package:flutter/material.dart';
import 'package:trabalho_final_prog_moveis/constants/app_colors.dart';

class PreencherCardTela extends StatefulWidget {
  final Function(Map<String, dynamic>) adicionarAnotacao;
  final Function(Map<String, dynamic>, Function(Map<String, dynamic>))
      editarAnotacao;
  final Map<String, dynamic>? anotacao;

  const PreencherCardTela({super.key, 
    required this.adicionarAnotacao,
    required this.editarAnotacao,
    this.anotacao,
  });

  @override
  _PreencherCardTelaState createState() => _PreencherCardTelaState();
}

class _PreencherCardTelaState extends State<PreencherCardTela> {
  late TextEditingController _disciplinaController;
  late TextEditingController _anotacaoController;

  @override
  void initState() {
    super.initState();
    _disciplinaController = TextEditingController(
        text: widget.anotacao != null ? widget.anotacao!['discipline'] : '');
    _anotacaoController = TextEditingController(
        text: widget.anotacao != null ? widget.anotacao!['annotation'] : '');
  }

  @override
  void dispose() {
    _disciplinaController.dispose();
    _anotacaoController.dispose();
    super.dispose();
  }

  void _salvarAnotacao() {
    final discipline = _disciplinaController.text.trim();
    final annotation = _anotacaoController.text.trim();

    if (discipline.isNotEmpty && annotation.isNotEmpty) {
      final anotacao = {
        'discipline': discipline,
        'annotation': annotation,
        'created_at': DateTime.now().toString(),
      };

      if (widget.anotacao != null) {
        widget.editarAnotacao(anotacao, widget.adicionarAnotacao);
      } else {
        widget.adicionarAnotacao(anotacao);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.anotacao != null ? 'Editar Anotação' : 'Nova Anotação'),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            anoto(
              "lib/assets/img/anotando.png",
            ),
            TextField(
              controller: _disciplinaController,
              decoration: const InputDecoration(
                labelText: 'Disciplina',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _anotacaoController,
              decoration: InputDecoration(
                labelText: 'Anotação',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarAnotacao,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.kPrimaryColor), // Replace with your desired color
              ),
              child: Text(widget.anotacao != null ? 'Salvar' : 'Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  Image anoto(String anotando) {
    return Image.asset(
      anotando,
      fit: BoxFit.fitWidth,
      width: 125,
      height: 256,
    );
  }
}
