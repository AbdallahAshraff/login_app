import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {super.key,
      required this.validator,
      required this.controller,
      required this.labelText,
      this.suffixIcon,
      this.keyboardType ,
      this.obscureText = false});
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
 final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }
}
