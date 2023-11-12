import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Google Sign In
  Future<void> hangleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await auth.signInWithCredential(credential);
      }
    } catch (e) {
      print("Error signing in with google $e");
    }
  }

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print("error signing out: $e");
    }
  }
}
