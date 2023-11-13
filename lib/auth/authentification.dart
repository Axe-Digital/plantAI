import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_ai/services/firestore.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final Firestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // late String?  firstName = auth.currentUser!.displayName!.split(' ')[0];
  String? get userId => auth.currentUser?.uid;
  // late String firstName ;

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

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      print(userId);
      await auth.currentUser!.delete();
    } catch (e) {
      print("error signing out: $e");
    }
  }

  String? firstName() {
    try {
      return auth.currentUser!.displayName!.split(' ')[0];
    } catch (e) {
      return 'e.toString()';
    }
  }
}
