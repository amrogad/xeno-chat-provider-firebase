import 'package:flutter/material.dart';

class XenoTextField extends StatelessWidget {
  String? title;
  String? Function(String?)? validator;
  String? value;
  XenoTextField({this.title, this.validator, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: validator,
    );
  }
}
