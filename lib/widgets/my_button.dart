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
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: widget.emailController.text,
                  password: widget.passwordController.text);
        } on FirebaseAuthException catch (e) {
          print("Error Error $e");

          if (e.code == 'user-not-found') {
            return showSnackBarMessage("No user found for that email.",
                context: context);
          } else if (e.code == 'wrong-password') {
            return showSnackBarMessage("Wrong password provided for that user.",
                context: context);
          }
        } catch (e) {
          print("Error Error $e");
        }

        await Firestore.getFirstName().then((value) {
          print("my_button");
          print(value);
          Firestore.saveUserName = value;
          if (auth.userId != null) {
            Navigator.pushReplacement(
                context,
                // ignore: prefer_const_constructors
                MaterialPageRoute(builder: (context) => HomeScreen(currentTabIndex: 0,)));
          }
        });
      } catch (e) {
        print(e);
      }
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
