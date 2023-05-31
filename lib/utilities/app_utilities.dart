import 'package:flutter/material.dart';
import '../constants/Colors.dart';

class Utilities {
  static void rotatedSpinner(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: XenoColors.primaryColor,
          ));
        });
  }

}
