import 'package:firebase_auth/firebase_auth.dart';
// import 'package:plant_ai/auth/authentification.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    signInWithEmailAndPassword() async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: widget.emailController.text,
                password: widget.passwordController.text);

        if (credential.user != null) {
          prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', credential.user.toString());
          setState(() {
            // widget.onPressed!();
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          return scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text("No User for the mail")));
        } else if (e.code == "wrong-password") {
          return scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text("Wrong password provided for that user")));
        }
      }
    }

    void signIn() async {
      signInWithEmailAndPassword().then((value) {
        if (auth.userId != null) {
          Navigator.pushReplacement(
              context,
              // ignore: prefer_const_constructors
              MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });
    }

    return InkWell(
      onTap: () {
        if (widget.formField.currentState!.validate()) {
          signIn();

          print("Data Added Successfully");
          // if (widget.user != null) {

          // }

          // passWordController.clear();
          // userNameController.clear();
          // lastNameController.clear();
          // contactController.clear();
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
