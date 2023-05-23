import 'package:flutter/material.dart';

class XenoSnackBar extends StatelessWidget {
  XenoSnackBar({this.message, super.key});
  String? message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(message ?? ''));
  }
}
