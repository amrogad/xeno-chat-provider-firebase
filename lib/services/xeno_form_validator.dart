import 'package:form_field_validator/form_field_validator.dart';

import '../viewmodels/register_view_model.dart';

class XenoFormValidator {
  String? Function(String?) firstNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a first name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) lastNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a last name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter an email address."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
    EmailValidator(errorText: 'The email is invalid.')
  ]);
  String? Function(String?) emailConfirmationValidator = MultiValidator([
    RequiredValidator(errorText: 'Please confirm your email address.'),
    ConfirmEmailValidator(errorText: "Emails don't match.")
  ]);
  String? Function(String?) passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter your password."),
    MinLengthValidator(6, errorText: "Please enter at least 6 characters."),
  ]);
  String? Function(String?) passwordConfirmationValidator = MultiValidator([
    RequiredValidator(errorText: 'Please confirm your password.'),
    MinLengthValidator(6, errorText: "Please enter at least 6 characters."),
    ConfirmPasswordValidator(errorText: "Passwords don't match."),
  ]);
}

class ConfirmEmailValidator extends TextFieldValidator {
  ConfirmEmailValidator({required String errorText}) : super(errorText);
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == registerViewModel.emailConfirmationController.text) {
      return true;
    } else {
      return false;
    }
  }
}

class ConfirmPasswordValidator extends TextFieldValidator {
  ConfirmPasswordValidator({required String errorText}) : super(errorText);
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == registerViewModel.passwordConfirmationController.text) {
      return true;
    } else {
      return false;
    }
  }
}
