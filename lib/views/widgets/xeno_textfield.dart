import 'package:flutter/material.dart';

class XenoTextField extends StatelessWidget {
  final String? title;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController controller;
  const XenoTextField({this.title, required this.controller, required this.validator, this.obscureText = false, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
