import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/constants/Colors.dart';
import '../constants/firebase_errors.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController emailConfirmationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: XenoColors.primaryColor,
            ));
          });
      if (registerFormKey.currentState!.validate()) {
        await firebaseAuth.createUserWithEmailAndPassword(email: emailConfirmationController.text, password: passwordConfirmationController.text);
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success',
          message: 'Your account has been created successfully!',
          contentType: ContentType.success,
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      if (context.mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseErrors.weakPassword) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'The password you used is too weak!',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        if (context.mounted) Navigator.of(context).pop();
      } else if (error.code == FirebaseErrors.emailInUse) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'The email is already in use!',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        if (context.mounted) Navigator.of(context).pop();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
