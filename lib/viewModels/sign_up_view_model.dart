import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:firebase_practice/utils/result.dart';
import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:flutter/material.dart';

import '../ui/states/password_state.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel({required FirebaseService firebaseService})
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

  void signUpWithEmailAndPassword(
    bool isEmailValid, {
    required Function(User? user) onSuccess,
    required Function(Exception) onFailure,
  }) {
    _highlightErrors();
    if (!isEmailValid || !passwordState.isValid) {
      return;
    }

    _firebaseService
        .signUpWithEmailAndPassword(
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
            onSuccess(event.data);
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
