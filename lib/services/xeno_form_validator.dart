import 'package:form_field_validator/form_field_validator.dart';

class XenoFormValidator {
  static final String? Function(String?) firstNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a first name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  static final String? Function(String?) lastNameValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a last name."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  static final String? Function(String?) emailAddressValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter an email address."),
    EmailValidator(errorText: 'The email is invalid.')
  ]);
  static final String? Function(String?) passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter your password."),
    MinLengthValidator(6, errorText: "Please enter at least 6 characters."),
  ]);
  static final String? Function(String?) roomTitleValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a room name."),
    MinLengthValidator(4, errorText: "Please enter at least 4 characters."),
  ]);
  static final String? Function(String?) roomDescValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter a room description."),
    MinLengthValidator(10, errorText: "Please enter at least 10 characters."),
  ]);
  static final String? Function(String?) messageValidator = MultiValidator([
    RequiredValidator(errorText: ""),
  ]);
}
