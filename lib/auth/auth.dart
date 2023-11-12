import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/login_page.dart';
// import 'package:plant_ai/model/user.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          // User is logged in
          Navigator.pushReplacement(
            context,
            // ignore: prefer_const_constructors
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // User is not logged in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
