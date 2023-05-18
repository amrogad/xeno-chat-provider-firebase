import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeno_chat/services/xeno_form_validator.dart';
import 'package:xeno_chat/views/widgets/xeno_button.dart';
import 'package:xeno_chat/views/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/views/widgets/xeno_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  static const String id = 'register-view';
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return XenoScaffold(
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
                title: 'First Name',
                validator: XenoFormValidator().firstName,
              ),
              XenoTextField(
                title: 'Last Name',
                validator: XenoFormValidator().lastName,
              ),
              XenoTextField(
                title: 'Username',
                validator: XenoFormValidator().userName,
              ),
              XenoTextField(
                title: 'Email',
                validator: XenoFormValidator().emailAddress,
              ),
              XenoTextField(
                title: 'Password',
                validator: XenoFormValidator().password,
              ),
              SizedBox(height: 50.h,),
              XenoButton(
                onTap: validateRegisterFormkey,
                text: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateRegisterFormkey() {
    //validate all text form fields before creating an account
    if (!registerFormKey.currentState!.validate()) {
      return;
    }
  }
}
