import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/utilities/xeno_form_validator.dart';
import 'package:xeno_chat/viewmodels/login_view_model.dart';
import 'package:xeno_chat/views/widgets/xeno_button.dart';
import 'package:xeno_chat/views/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/views/widgets/xeno_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String id = 'login-view';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void dispose() {
    loginViewModel.emailAddressController.dispose();
    loginViewModel.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        loginViewModel;
      },
      child: XenoScaffold(
        appBarTitle: 'Create Account',
        resizeToAvoidBottomInset: false,
        body: Form(
          key: loginViewModel.loginFormKey,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XenoTextField(
                  controller: loginViewModel.emailAddressController,
                  title: 'Email Address',
                  validator: XenoFormValidator.emailAddressValidator,
                ),
                XenoTextField(
                  controller: loginViewModel.passwordController,
                  title: 'Password',
                  validator: XenoFormValidator.passwordValidator,
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () {
                    loginViewModel.validateAndSignIn(context);
                  },
                  child: const XenoButton(
                    text: 'Login',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
