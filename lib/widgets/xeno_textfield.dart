import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/constants/Fonts.dart';

class XenoTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  const XenoTextField(
      {this.keyboardType,
      this.onChanged,
      this.hintStyle,
      this.hintText,
      this.title,
      required this.controller,
      required this.validator,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: XenoFonts.bodyTextPrimary(context)?.copyWith(fontSize: 12.sp),
          border: const OutlineInputBorder(borderSide: BorderSide(color: XenoColors.primaryColor)),
          hintText: hintText,
          hintStyle: hintStyle,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: XenoColors.primaryColor)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: XenoColors.primaryColor),
          ),
        ),
        style: XenoFonts.bodyTextPrimary(context),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
