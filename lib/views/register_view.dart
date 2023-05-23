import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/services/xeno_form_validator.dart';
import 'package:xeno_chat/viewmodels/register_view_model.dart';
import 'package:xeno_chat/views/widgets/xeno_button.dart';
import 'package:xeno_chat/views/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/views/widgets/xeno_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  static const String id = 'register-view';
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController emailConfirmationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        registerViewModel;
      },
      child: XenoScaffold(
        appBarTitle: 'Create Account',
        resizeToAvoidBottomInset: false,
        body: Form(
          key: registerFormKey,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XenoTextField(
                  controller: firstNameController,
                  title: 'First Name',
                  validator: XenoFormValidator().firstNameValidator,
                ),
                XenoTextField(
                  controller: lastNameController,
                  title: 'Last Name',
                  validator: XenoFormValidator().lastNameValidator,
                ),
                XenoTextField(
                  controller: emailAddressController,
                  title: 'Email',
                  validator: XenoFormValidator().emailAddressValidator,
                ),
                XenoTextField(
                  controller: emailConfirmationController,
                  title: 'Email Confirmation',
                  validator: XenoFormValidator().emailConfirmationValidator,
                ),
                XenoTextField(
                  controller: passwordController,
                  title: 'Password',
                  validator: XenoFormValidator().passwordValidator,
                  obscureText: true,
                ),
                XenoTextField(
                  controller: passwordConfirmationController,
                  title: 'Password Confirmation',
                  validator: XenoFormValidator().passwordConfirmationValidator,
                  obscureText: true,
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: (){
                    validateAndCreateAccount();
                  },
                  child: XenoButton(
                    text: 'Register',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Validate all text form fields and create an account on firebase with email and password
  Future<void> validateAndCreateAccount() async {
    if (registerFormKey.currentState!.validate()) {
      registerViewModel.validateAndCreateAccount(email: emailConfirmationController.text, password: passwordConfirmationController.text);
    }
  }
}
