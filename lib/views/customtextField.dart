import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? Controller;
  final bool obscureText;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isPassword;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;

  const CustomTextField(
      {super.key,
      this.Controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.isPassword = false,
      this.validator,
      this.decoration});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText,
        controller: Controller,
        decoration: decoration?.copyWith(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
