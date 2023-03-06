import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseUser? _firebaseUser(User? user) {
  //   print(user?.uid);
  //   // if (user != null) {
  //   //   // print(user.uid);
  //   //   FirebaseUser fUser = FirebaseUser(uid: user.uid);
  //   //   print(fUser.getUid());
  //   //   return fUser;
  //   // } else {
  //   //   return null;
  //   // }
  //   return user != null ? FirebaseUser(uid: user.uid) : null;
  // }

  Stream<User?> get user {
    // print(_auth.authStateChanges());
    return _auth.authStateChanges();
  }

  Future signInEmailPassword(Profile _login) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _login.email.toString(), password: _login.password.toString());
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
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
      return (user);
    } on FirebaseAuthException catch (e) {
      return user;
    } catch (e) {
      return e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
