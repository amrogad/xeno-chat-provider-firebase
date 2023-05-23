import 'package:flutter/material.dart';

class XenoTextField extends StatelessWidget {
  String? title;
  String? Function(String?)? validator;
  String? value;
  bool obscureText;
  TextEditingController controller;
  XenoTextField({this.title,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    super.key});

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
