import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:xeno_chat/utilities/app_utilities.dart';
import 'package:xeno_chat/views/widgets/xeno_snackbar.dart';
import '../constants/firebase_errors.dart';
import '../models/User.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailConfirmationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount(BuildContext context) async {
    try {
      AppUtilities.rotatedSpinner(context);
      if (registerFormKey.currentState!.validate()) {
        await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        await createFireStoreUser();
      }
      if (context.mounted) {
        Navigator.pop(context);
        XenoSnackBars.showXenoSuccessSnackBar(context, message: 'Your account has been created!');
      }
    } on auth.FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.weakPassword) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, message: 'Your password is too weak!');
        }
      } else if (error.code == FirebaseErrors.emailInUse) {
        if (context.mounted) {
          Navigator.pop(context);
          XenoSnackBars.showXenoErrorSnackBar(context, message: 'That email is already in use!');
        }
      }
    } catch (error) {
      XenoSnackBars.showXenoErrorSnackBar(context, message: 'An error has occurred please try again later!');
      Navigator.pop(context);
    }
  }

  // Create a user and add it to FireStore
  Future<void> createFireStoreUser() async {
    final user = User(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
    );
    await db.collection('Users').add(user.toJson());
  }
}
