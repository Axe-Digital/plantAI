import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:plant_ai/widgets/snackbar_utils.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? get userId => auth.currentUser?.uid;

  // Google Sign In
  Future<void> hangleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await auth.signInWithCredential(credential);
        // firstName = user?.displayName;
      }
    } catch (e) {
      print("Error signing in with google $e");
    }
  }

  Future<void> handleSignOut(Auth auth) async {
    try {
      print(' AUTH : ${FirebaseAuth.instance.currentUser?.uid}');
      await googleSignIn.signOut();
      await auth.auth.signOut();
      // print(object)
      print(' AUTH : ${FirebaseAuth.instance.currentUser?.uid}');
      await auth.auth.currentUser!.delete();
    } catch (e) {
      print("error signing out: $e");
    }
  }

  String? firstNameAuth() {
    return auth.currentUser?.displayName?.split(' ')[0];
  }

  signInWithEmailAndPassword(String email, String password,
      dynamic Function(String) showErrorSnackbar) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return showErrorSnackbar("No user found for that email.");
      } else if (e.code == "wrong-password") {
        return showErrorSnackbar("Wrong password provided for that user");
      }
    }
  }

  dynamic createUserWithEmailAndPassword(
    email,
    password,
    dynamic Function(String) showErrorSnackbar,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return showErrorSnackbar("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return showErrorSnackbar("'The account already exists for that email");
      }
    } catch (e) {
      print(e);
    }
  }
}
