import 'dart:async';
import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_ai/widgets/snackbar_utils.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static String? get userId => _auth.currentUser?.uid;
  static User? get currentUser => _auth.currentUser;

  // Google Sign In
  static Future<void> hangleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await _auth.signInWithCredential(credential);
        // firstName = user?.displayName;
      }
    } catch (e) {
      print("Error signing in with google $e");
    }
  }



  static Future<void> logout() async => _auth.signOut();

  static Future<void> handleSignOut() async {
    try {
      print(' AUTH : ${FirebaseAuth.instance.currentUser?.uid}');
      // print(_googleSignIn);
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("error signing out: $e");
    }
  }

  String? firstNameAuth() {
    return _auth.currentUser?.displayName?.split(' ')[0];
  }

  static signInWithEmailAndPassword(
    BuildContext context, {
    String? email,
    String? password,
  }) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        if (!context.mounted) return;

        showSnackBarMessage("No user found for that email.", context: context);
      } else if (e.code == "wrong-password") {
        if (!context.mounted) return;

        return showSnackBarMessage("Wrong password provided for that user.",
            context: context);
      }
    }
  }

  static dynamic createUserWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (!context.mounted) return;
        return showSnackBarMessage("The password provided is too weak.",
            context: context);
      } else if (e.code == 'email-already-in-use') {
        if (!context.mounted) return;
        return showSnackBarMessage("'The account already exists for that email",
            context: context);
      }
    } catch (e) {
      print(e);
    }
  }
}
