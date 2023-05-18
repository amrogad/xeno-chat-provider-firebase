import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XenoScaffold extends StatelessWidget {
  String? appBarTitle;
  Widget? body;
  bool? resizeToAvoidBottomInset;
  XenoScaffold({this.appBarTitle, this.body, this.resizeToAvoidBottomInset, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
            title: Text(
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
