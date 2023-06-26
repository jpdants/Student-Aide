import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_final_prog_moveis/constants/app_colors.dart';

class AddPlanWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const AddPlanWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 143,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kSecondaryColor,
        border: Border.all(color: AppColors.kPrimaryColor, width: 2),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          '+ Add Plan',
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class AnotacaoWidget extends StatelessWidget {
  final String descricao;
  final DateTime dataCriacao;
  final List<String> tags;

  const AnotacaoWidget({super.key, 
    required this.descricao,
    required this.dataCriacao,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataCriacao); // Formatando a data

    return Container(
      width: 252,
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kSecondaryColor,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (String tag in tags)
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300],
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 4,
            right: 8,
            child: Text(
              'Data de Criação: $formattedDate', // Utilizando a data formatada
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}