import 'package:flutter/material.dart';
import 'package:flutter_task_management_app/utils/colors/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? borderRadius;
  final int? maxLines;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.borderRadius,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textHolder,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
      ),
    );
  }
}
