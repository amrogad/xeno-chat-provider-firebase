import 'package:flutter/material.dart';
import 'package:xeno_chat/views/widgets/xeno_scaffold.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String id = 'register-view';

  @override
  Widget build(BuildContext context) {
    return XenoScaffold(
      appBarTitle: 'Create Account',
    );
  }
}
