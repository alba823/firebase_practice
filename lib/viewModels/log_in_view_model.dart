import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:firebase_practice/utils/result.dart';
import 'package:flutter/cupertino.dart';

import '../ui/states/password_state.dart';

class LogInViewModel extends ChangeNotifier {
  LogInViewModel({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

  PasswordState _passwordState = PasswordState();

  PasswordState get passwordState => _passwordState;

  bool _isButtonLoading = false;

  bool get isButtonLoading => _isButtonLoading;

  void onEmailChanged(String? newValue) {
    _emailController.text = newValue ?? "";
  }

  void onPasswordChanged(String? newValue) {
    _passwordState = _passwordState.checkPassword(newValue);
    notifyListeners();
  }

  String? validateEmail({
    String? email,
    required String requiredFieldMessage,
    required String invalidEmailMessage,
  }) {
    if (email == null || email.isEmpty) {
      return requiredFieldMessage;
    } else if (!email.isValidEmail) {
      return invalidEmailMessage;
    } else {
      return null;
    }
  }

  void _highlightErrors() {
    _passwordState = _passwordState.setHighlightErrors(
        !passwordState.containsNumbers ||
            !passwordState.containsUppercase ||
            !passwordState.containsLowercase ||
            !passwordState.correctLength);
    notifyListeners();
  }

  void logInWithEmailAndPassword(
    bool isEmailValid, {
    required Function(User user) onSuccess,
    required Function(Exception) onFailure,
  }) {
    _highlightErrors();
    if (!isEmailValid) {
      return;
    }

    _firebaseService
        .logInWithEmailAndPassword(
            emailController.text, passwordController.text)
        .listen((event) {
      switch (event) {
        case Loading():
          {
            _isButtonLoading = true;
            notifyListeners();
          }
        case Success():
          {
            if (_firebaseService.currentUser == null) {
              onFailure(Exception("User is null"));
            } else {
              onSuccess(_firebaseService.currentUser!);
            }
          }
        case Failure():
          {
            onFailure(event.exception);
          }
      }
    }).onDone(() {
      _isButtonLoading = false;
      notifyListeners();
    });
  }
}

extension EmailExtension on String {
  bool get isValidEmail => EmailValidator.validate(this);
}
