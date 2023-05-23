import 'package:form_field_validator/form_field_validator.dart';

class XenoFormValidator {
  String? Function(String?) firstNameValidator = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) lastNameValidator = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
    EmailValidator(errorText: 'The email is invalid.')
  ]);
  String? Function(String?) emailConfirmationValidator = MultiValidator([]);
  String? Function(String?) passwordValidator = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) passwordConfirmationValidator = MultiValidator([
    RequiredValidator(errorText: ''),
  ]);
}

//Need state management
// class ConfirmEmailValidator extends TextFieldValidator {
//   ConfirmEmailValidator({required String errorText}) : super(errorText);
//   @override
//   bool get ignoreEmptyValues => false;
//
//   @override
//   bool isValid(String? value) {
//     if (value == ) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
//
// class ConfirmPasswordValidator extends TextFieldValidator {
//   ConfirmPasswordValidator({required String errorText}) : super(errorText);
//   @override
//   bool get ignoreEmptyValues => false;
//
//   @override
//   bool isValid(String? value) {
//     if (value == ) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
