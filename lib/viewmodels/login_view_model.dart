import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/services/services.dart';
import '../constants/firebase_errors.dart';
import '../views/widgets/xeno_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Sign in with email and password
  Future<void> validateAndSignIn(BuildContext context) async {
    try {
      Services.rotatedSpinner(context);
      if (loginFormKey.currentState!.validate()) {
        await firebaseAuth.signInWithEmailAndPassword(email: emailAddressController.text, password: passwordController.text);
      }
      if (context.mounted) {
        Navigator.pop(context);
        //TODO: Add navigation to home screen
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.userNotFound) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, title: 'Error!', message: 'No user found for that email!');
        }
      } else if (error.code == FirebaseErrors.wrongPassword) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, title: 'Error!', message: 'Wrong password provided for that email!');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
