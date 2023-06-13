import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/viewmodels/auth/login_viewmodel.dart';
import 'package:xeno_chat/views/auth/register_view.dart';
import 'package:xeno_chat/widgets/xeno_button.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/widgets/xeno_textfield.dart';
import '../../services/xeno_form_validator.dart';

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
    loginViewModel.emailController.dispose();
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
        appBarTitle: 'Sign In',
        body: Form(
          key: loginViewModel.loginFormKey,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XenoTextField(
                  controller: loginViewModel.emailController,
                  title: 'Email Address',
                  validator: XenoFormValidator.emailAddressValidator,
                ),
                XenoTextField(
                  controller: loginViewModel.passwordController,
                  title: 'Password',
                  validator: XenoFormValidator.passwordValidator,
                  obscureText: true,
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () {
                    loginViewModel.validateAndSignIn(context);
                  },
                  child: XenoButton(
                    text: 'Login',
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RegisterView.id);
                  },
                  child: XenoButton(
                    text: 'Sign up',
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
