import 'package:firebase_auth/firebase_auth.dart';
// import 'package:plant_ai/auth/authentification.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/widgets/snackbar_utils.dart';

class MyButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Future signIn() async {
      try {
        await Auth.signInWithEmailAndPassword(
          context,
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        print("Error Error $e");
        if (!context.mounted) return;

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
        Firestore.userName = value;
        if (Auth.userId != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  // ignore: prefer_const_constructors
                  builder: (context) => HomeScreen()));
        }
      });
    }

    return InkWell(
      onTap: () {
        if (formField.currentState!.validate()) {
          signIn();
          print("Data Added Successfully");
        }
      },
      child: Container(
          width: width - 50,
          height: 50,
          decoration: BoxDecoration(color: Colors.orange),
          child: Center(
              child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))),
    );
  }
}
