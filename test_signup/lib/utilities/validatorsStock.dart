import 'package:password_strength/password_strength.dart';
import 'package:string_validator/string_validator.dart';

String? validateEmail(String? value) {
  if (value != null) {
    if (trim(value).isEmpty) {
      return "Your Email is required";
    } else if (!isEmail(value)) {
      return "Please provide a valid Email address";
    }
  } else {
    return "Please provide a valid Email address";
  }
  return null;
}

String? validateName(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return "Your name is required";
    } else if (!isAlpha(value)) {
      return "Your name must only contain letters";
    }
  } else
    return "Your name is required";
  return null;
}

String? validatePhone(String? value) {
  if (trim(value!).isEmpty) {
    return "Your phone is required";
  } else if (value.length >= 10 && isNumeric(value.substring(1))) {
    return "Your phone must only contain numbers";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value != null) {
    if (trim(value).isEmpty) {
      return "a password is required";
    } else if (estimatePasswordStrength(value) < 0.8) {
      return "You need a stronger pasword";
    }
    return null;
  }
}
