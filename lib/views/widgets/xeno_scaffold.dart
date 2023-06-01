import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XenoScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  const XenoScaffold({this.appBarTitle, this.body, this.resizeToAvoidBottomInset, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: AutoSizeText(
              appBarTitle ?? '',
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: body,
        )
      ],
    );
  }
}
