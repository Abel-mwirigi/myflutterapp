import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/customtext.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();},
        child: CustomText(
          label: label,
        ));
  }
}
