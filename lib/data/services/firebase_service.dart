import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/utils/result.dart';

abstract class FirebaseService {
  User? get currentUser;

  Stream<void> signOut();

  Stream<void> sendEmailVerification();

  Stream<void> logInWithEmailAndPassword(String email, String password);

  Stream<Result> signUpWithEmailAndPassword(String email, String password);
}

final class FirebaseServiceImpl implements FirebaseService {
  final FirebaseAuth _auth;

  FirebaseServiceImpl({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<void> logInWithEmailAndPassword(String email, String password) async* {
    yield Loading();
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      yield Success(credentials);
    } on Exception catch (e) {
      yield Failure(e);
    }
  }

  @override
  Stream<void> signOut() async* {
    try {
      yield Loading();
      await _auth.signOut();
      yield Success(null);
    } on Exception catch (e) {
      yield Failure(e);
    }
  }

  @override
  Stream<Result> signUpWithEmailAndPassword(
      String email, String password) async* {
    try {
      yield Loading();
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      yield Success(userCredentials.credential);
    } on Exception catch (e) {
      yield Failure(e);
      switch (e) {
        default:
          break;
      }
    }
  }

  @override
  Stream<void> sendEmailVerification() async* {
    try {
      yield Loading();
      if (_auth.currentUser == null) throw Exception("User is null");
      await _auth.currentUser?.sendEmailVerification();
      yield Success(null);
    } on Exception catch (e) {
      yield Failure(e);
    }
  }
}
