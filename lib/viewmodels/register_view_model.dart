import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/utilities/app_utilities.dart';
import 'package:xeno_chat/views/widgets/xeno_snackbar.dart';
import '../constants/firebase_errors.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController emailConfirmationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount(BuildContext context) async {
    try {
      Utilities.showLoader(context);
      if (registerFormKey.currentState!.validate()) {
        await firebaseAuth.createUserWithEmailAndPassword(email: emailConfirmationController.text, password: passwordConfirmationController.text);
      }
      if (context.mounted) {
        Navigator.pop(context);
        XenoSnackBars.showXenoSuccessSnackBar(context, title: 'Success!', message: 'Your account has been created!');
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.weakPassword) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, title: 'Error!', message: 'Your password is too weak!');
        }
      } else if (error.code == FirebaseErrors.emailInUse) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, title: 'Error!', message: 'That email is already in use!');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
