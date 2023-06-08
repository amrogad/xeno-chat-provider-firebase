import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Colors.dart';

class XenoFonts{
  static TextStyle? bodyTextWhite(BuildContext context) {
    return GoogleFonts.ubuntu(color: Colors.white, fontWeight: FontWeight.w500);
  }
  static TextStyle? bodyTextPrimary(BuildContext context) {
    return GoogleFonts.ubuntu(color: XenoColors.primaryColor, fontWeight: FontWeight.w500);
  }
}