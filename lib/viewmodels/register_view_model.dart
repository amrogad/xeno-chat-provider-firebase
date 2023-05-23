import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/firebase_errors.dart';
import '../views/widgets/xeno_snackbar.dart';

class RegisterViewModel extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.weakPassword) {
        XenoSnackBar(message: 'Password is too weak!');
      } else if (error.code == FirebaseErrors.emailInUse) {
        XenoSnackBar(message: 'This email is already in use');
      }
    } catch (error) {
      print(error);
    }
  }
}
