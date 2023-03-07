import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get currentUser {
    User? user = _auth.currentUser;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  // StreamSubscription<User?> get user {
  //   // print(_auth.authStateChanges());
  //   return _auth.userChanges();
  // }

  // Stream<User?> get user {
  //   // print(_auth.authStateChanges());
  //   return _auth.userChanges();
  // }

  Future signInEmailPassword(Profile _login) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _login.email.toString(), password: _login.password.toString());
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      // print(e);
      return e;
    }
  }

  Future registerEmailPassword(Profile _login) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      await user?.updateDisplayName(_login.userName.toString());
      return user;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e;
    }
  }
}
