import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true.toString();
    } on FirebaseAuthException catch(e) {
      return e.message!;
    }
  }

  // User? getUser() {
  //   try {
  //     return _firebaseAuth.currentUser;
  //   } on FirebaseAuthException {
  //     return null;
  //   }
  // }
}
