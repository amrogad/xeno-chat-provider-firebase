import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Fonts.dart';

class XenoScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  final bool? centerTitle;
  final Widget? floatingActionButton;
  final Widget? leading;
  final List<Widget>? actions;
  const XenoScaffold(
      {this.appBarTitle,
      this.actions,
      this.leading,
      this.body,
      this.resizeToAvoidBottomInset = false,
      this.centerTitle = true,
      this.floatingActionButton,
      super.key});

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
            leading: leading,
            actions: actions,
            centerTitle: centerTitle,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: AutoSizeText(
              appBarTitle ?? '',
              style: XenoFonts.bodyTextWhite(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: floatingActionButton,
          body: body,
        )
      ],
    );
  }
}
