import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/providers/user_provider.dart';
import 'package:xeno_chat/widgets/xeno_snackbar.dart';
import '../../constants/firebase_errors.dart';
import '../../models/UserModel.dart';
import '../../services/services.dart';
import '../../views/home/home_view.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailConfirmationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final UserProvider userProvider = UserProvider();

  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount(BuildContext context) async {
    try {
      Services.rotatedSpinner(context);
      if (registerFormKey.currentState!.validate()) {
        var result = await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        final user = UserModel(
          id: result.user?.uid ?? '',
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
        );
        userProvider.createUserinFireStore(user);
      }
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeView.id);
        XenoSnackBars.showXenoSuccessSnackBar(context, message: 'Your account has been created!');
      }
    } on FirebaseAuthException catch (error) {
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
}
