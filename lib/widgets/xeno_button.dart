import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeno_chat/constants/Colors.dart';

import '../constants/Fonts.dart';

class XenoButton extends StatelessWidget {
  final String? text;
  double? height;
  double? width;
  XenoButton({this.text, this.height, this.width, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: XenoColors.primaryColor,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      height: height ?? 35.h,
      width: width ?? 130.w,
      child: Center(
        child: AutoSizeText(
          text!,
          style: XenoFonts.bodyTextWhite(context),
        ),
      ),
    );
  }
}
