import '../constant.dart';

String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return kPhoneNumberNullError;
  } else if (value.length != 10) {
    return kInvalidPhoneError;
  }
  return null;
}

String? validateString(String? value, String label) {
  if (value!.isEmpty) {
    return "Invalid $label";
  }
  return null;
}
