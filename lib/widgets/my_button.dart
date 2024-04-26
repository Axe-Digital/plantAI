import 'package:firebase_auth/firebase_auth.dart';
// import 'package:plant_ai/auth/authentification.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/widgets/snackbar_utils.dart';

class MyButton extends StatefulWidget {
  final GlobalKey<FormState> formField;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final String title;

  const MyButton({
    super.key,
    required this.formField,
    required this.passwordController,
    required this.emailController,
    required this.title,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isLoading = true;
  late ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
  // late SharedPreferences prefs;
  final auth = Auth();
  late UserCredential credential;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    signIn() async {
      try {
        await auth.signInWithEmailAndPassword(
            email: widget.emailController.text,
            password: widget.passwordController.text,
            showErrorSnackbar: showSnackBarMessage);
      } on FirebaseAuthException catch (e) {
        print("Error Error $e");
        if (!mounted) return;

        if (e.code == 'user-not-found') {
          // await showSnackBarMessage(
          //   "No user found for that email.",
          // );
        } else if (e.code == 'wrong-password') {
          // await showSnackBarMessage(
          //   "Wrong password provided for that user.",
          // );
        }
      } catch (e) {
        print("Error Error $e");
      }

      await Firestore.getFirstName().then((value) {
        print("my_button");
        print("value : $value");
        Firestore.saveUserName = value;
        if (auth.userId != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  // ignore: prefer_const_constructors
                  builder: (context) => HomeScreen(
                   
                      )));
        }
      });
    }

    return InkWell(
      onTap: () {
        if (widget.formField.currentState!.validate()) {
          signIn();
          print("Data Added Successfully");
        }
      },
      child: Container(
        height: 50,
        width: width * 0.6,
        decoration: BoxDecoration(
            color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: isLoading
              ? Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
