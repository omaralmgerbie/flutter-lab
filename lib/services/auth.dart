import 'package:firebase_auth/firebase_auth.dart';


class Auth {

  FirebaseAuth auth = FirebaseAuth.instance;


//Create an accoun
  createUserWithEmailAndPassword(email, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return "Account created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'error occurred';
    }
  }


//Sign in
  signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }


//Reset Password

  passwordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,

      );
      return "Email Sent";
    } catch (e) {
      return "Error occurred";
    }
  }

//Sign out

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}