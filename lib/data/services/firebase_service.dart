import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseService {
  User? get currentUser;

  Future<void> signOut();

  Future<void> logInWithCredential(AuthCredential credential);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<void> signUpWithEmailAndPassword(String email, String password);
}

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredentials.credential == null) throw Exception();
    } catch (e) {
      switch (e) {
        default:
          break;
      }
    }
  }

  @override
  Future<void> logInWithCredential(AuthCredential credential) async {
    await _auth.signInWithCredential(credential);
  }
}