import 'package:form_field_validator/form_field_validator.dart';

class XenoFormValidator {
  String? Function(String?) firstName = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) lastName = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) userName = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
  String? Function(String?) emailAddress = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
    EmailValidator(errorText: 'The email is invalid.')
  ]);
  String? Function(String?) password = MultiValidator([
    RequiredValidator(errorText: "This field is required."),
    MinLengthValidator(3, errorText: "Please enter at least 3 characters."),
  ]);
}
