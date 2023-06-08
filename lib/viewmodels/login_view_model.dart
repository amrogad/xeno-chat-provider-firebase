import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/providers/user_provider.dart';
import 'package:xeno_chat/services/services.dart';
import 'package:xeno_chat/views/home_view.dart';
import '../constants/firebase_errors.dart';
import '../widgets/xeno_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserProvider userProvider = UserProvider();

  // Sign in with email and password
  Future<void> validateAndSignIn(BuildContext context) async {
    try {
      Services.rotatedSpinner(context);
      if (loginFormKey.currentState!.validate()) {
        var logged = await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        await userProvider.readUserDataInFireStore(logged.user?.uid ?? '');
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, HomeView.id);
          Navigator.pop(context);
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.userNotFound) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, message: 'No user found for that email!');
        }
      } else if (error.code == FirebaseErrors.wrongPassword) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, message: 'Wrong password provided for that email!');
        }
      }
    } catch (error) {
      XenoSnackBars.showXenoErrorSnackBar(context, message: 'An error has occurred please try again later!');
      Navigator.pop(context);
    }
  }
}
