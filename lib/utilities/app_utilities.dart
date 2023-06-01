import 'package:flutter/material.dart';
import '../constants/Colors.dart';

class AppUtilities {
  static void rotatedSpinner(BuildContext context, {bool? barrierDismissible}) {
    showDialog(
      barrierDismissible: barrierDismissible ?? false,
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: XenoColors.primaryColor,
          ));
        });
  }
}
