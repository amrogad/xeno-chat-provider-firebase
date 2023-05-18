import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeno_chat/constants/Colors.dart';

class XenoButton extends StatelessWidget {
  Function()? onTap;
  String? text;
  XenoButton({this.onTap, this.text, super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 100.w),
        color: XenoColors().primaryColor,
        child: Text(
          text ?? '',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
