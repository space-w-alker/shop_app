import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future loginWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future signUpWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Stream<User?> getAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
