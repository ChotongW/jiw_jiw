// -----------------------------------------------------------------------------
// auth.dart
// -----------------------------------------------------------------------------
//
// This header file contains functions for efficiently middleware autentication.
// for easily to use we crate class AuthService.

import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile.dart';

// -----------------------------------------------------------------------------
// AuthService
// -----------------------------------------------------------------------------
//
// The AuthService class is create Firebase Authen instance
// for login and register by email firebase authentication.
// we use this class as middleware for login and register.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // currentUser()
  // this function return instance of User class that contain user data if logged in.
  // implement User class from firebase auth
  // if not logged in return null.

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

  // signInEmailPassword(_login)
  // this function act as middleware for login.
  // required _login variable that is instance of Profile class.
  // implement User class from firebase auth
  // return instance of User class that contain user data.
  // if error return error.

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

  // registerEmailPassword(_login)
  // this function act as middleware for register.
  // required _login variable that is instance of Profile class.
  // implement User class from firebase auth
  // return instance of User class that contain user data.
  // if error return error.

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

  // signOut()
  // this function use for signout.
  // implement Firebase Auth instance
  // return state of signout
  // if error return error.

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e;
    }
  }
}
