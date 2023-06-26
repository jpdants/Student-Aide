import 'package:flutter/material.dart';
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
