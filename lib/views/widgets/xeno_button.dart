import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeno_chat/constants/Colors.dart';

class XenoButton extends StatelessWidget {
  final String? text;
  const XenoButton({this.text, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 30.h,
      color: XenoColors.primaryColor,
      child: Center(
        child: AutoSizeText(
          text!,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
