import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  Future signUp(
      {required String email,
      required String password,
      required String name,
      required String phoneNo}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";
          break;
        default:
          return "Login failed. Please try again.";
          break;
      }
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    String? result;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          return null;
        } else {
          try {
            await FirebaseAuth.instance.signOut();
          } finally {}
          result = "Agents/Admin Account Not Allowed";
        }
      });
      return result;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";
          break;
        default:
          return "Login failed. Please try again.";
          break;
      }
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
