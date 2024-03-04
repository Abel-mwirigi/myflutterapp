import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/customtext.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback action;

  const CustomButton({
    super.key,
    required this.label,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: action,
        child: CustomText(
          label: label,
        ));
  }
}
