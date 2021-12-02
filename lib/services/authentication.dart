import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!.uid;
  }

  @override
  Future<String> currentUserUid() async {
    final user = _firebaseAuth.currentUser!;
    return user.uid;
  }

  @override
  getFirebaseAuth() {
    return _firebaseAuth;
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = _firebaseAuth.currentUser;
    return user!.emailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    user!.sendEmailVerification();
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!.uid;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
