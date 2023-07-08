import 'package:flutter/foundation.dart';

import '../data/services/firebase_service.dart';
import '../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  bool _isSignOutLoading = false;

  bool get isSignOutLoading => _isSignOutLoading;

  bool _isVerifyEmailLoading = false;

  bool get isVerifyEmailLoading => _isVerifyEmailLoading;

  void sendEmailVerification({
    required VoidCallback onSuccess,
    required Function(Exception) onFailure,
  }) {
    _firebaseService.sendEmailVerification().listen((event) {
      switch (event) {
        case Loading(): {
          _isVerifyEmailLoading = true;
          notifyListeners();
        }
        case Failure(): {
          onFailure(event.exception);
        }
        case Success(): {
          onSuccess();
        }
      }
    }).onDone(() {
      _isVerifyEmailLoading = false;
      notifyListeners();
    });
  }

  void signOut({
    required VoidCallback onSuccess,
    required Function(Exception) onFailure,
  }) {
    _firebaseService.signOut().listen((event) {
      switch (event) {
        case Loading(): {
          _isSignOutLoading = true;
          notifyListeners();
        }
        case Failure(): {
          onFailure(event.exception);
        }
        case Success(): {
          onSuccess();
        }
      }
    }).onDone(() {
      _isSignOutLoading = false;
      notifyListeners();
    });
  }
}
