import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/utilities/app_utilities.dart';
import 'package:xeno_chat/views/widgets/xeno_snackbar.dart';
import '../constants/firebase_errors.dart';
import '../models/MyUser.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailConfirmationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Create an account on firebase with email and password
  Future<void> validateAndCreateAccount(BuildContext context) async {
    try {
      AppUtilities.rotatedSpinner(context);
      if (registerFormKey.currentState!.validate()) {
        var result = await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        MyUser user = MyUser(id: result.user!.uid, firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text);

        if (result.user != null) {
          await createFireStoreUser(user);
        }
      }

      if (context.mounted) {
        Navigator.pop(context);
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

  CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.path)
        .withConverter(fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!), toFirestore: (user, _) => user.toJson());
  }

  Future<void> createFireStoreUser(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }
}
