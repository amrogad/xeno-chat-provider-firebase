import 'package:form_field_validator/form_field_validator.dart';

class XenoFormValidator {
  static String? Function(String?) firstNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a first name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  static String? Function(String?) lastNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a last name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  static String? Function(String?) emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter an email address."),
    EmailValidator(errorText: 'The email is invalid.')
  ]);
  static String? Function(String?) passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter your password."),
    MinLengthValidator(6, errorText: "Please enter at least 6 characters."),
  ]);
}
