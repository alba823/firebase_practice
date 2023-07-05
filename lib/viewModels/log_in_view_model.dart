import 'package:email_validator/email_validator.dart';
import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:flutter/foundation.dart';

class LogInViewModel extends ChangeNotifier {
  LogInViewModel({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  CustomFormInput _emailFormInput = CustomFormInput();

  CustomFormInput get emailFormInput => _emailFormInput;

  CustomFormInput _passwordFormInput = CustomFormInput();

  CustomFormInput get passwordFormInput => _passwordFormInput;

  PasswordState _passwordState = PasswordState();

  PasswordState get passwordState => _passwordState;

  void onEmailChanged(String? newValue) {
    _emailFormInput = _emailFormInput.copyWith(value: newValue);
  }

  void onPasswordChanged(String? newValue) {
    _passwordFormInput = _passwordFormInput.copyWith(value: newValue);
    _passwordState = _passwordState.checkPassword(newValue);
    notifyListeners();
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Required field";
    } else if (!email.isValidEmail) {
      return "Email is not valid";
    } else {
      return null;
    }
  }

  void highlightErrors() {
    _passwordState = _passwordState.setHighlightErrors(true);
    notifyListeners();
  }
}

extension EmailExtension on String {
  bool get isValidEmail => EmailValidator.validate(this);
}

class PasswordState {
  final bool highlightErrors;
  final bool containsNumbers;
  final bool containsLowercase;
  final bool containsUppercase;
  final bool correctLength;

  PasswordState({
    bool? highlightErrors,
    bool? containsNumbers,
    bool? containsLowercase,
    bool? containsUppercase,
    bool? correctLength,
  }): highlightErrors = highlightErrors ?? false,
        containsNumbers = containsNumbers ?? false,
        containsLowercase = containsLowercase ?? false,
        containsUppercase = containsUppercase ?? false,
        correctLength = correctLength ?? false;

  PasswordState checkPassword(String? password) {
    final containsNumbers = password?.contains(RegExp("[0-9]"));
    final containsLowercase = password?.contains(RegExp("[a-z]"));
    final containsUppercase = password?.contains(RegExp("[A-Z]"));
    final correctLength = (password?.length ?? 0) >= 8;

    return PasswordState(
      highlightErrors: highlightErrors,
      containsNumbers: containsNumbers,
      containsLowercase: containsLowercase,
      containsUppercase: containsUppercase,
      correctLength: correctLength,
    );
  }

  PasswordState setHighlightErrors(bool value) =>
      PasswordState(
        highlightErrors: value,
        containsNumbers: containsNumbers,
        correctLength: correctLength,
        containsUppercase: containsUppercase,
        containsLowercase: containsLowercase,
      );
}

class CustomFormInput {
  final String? value;

  CustomFormInput({this.value});

  CustomFormInput copyWith({String? value}) {
    return CustomFormInput(
        value: value ?? this.value);
  }
}
