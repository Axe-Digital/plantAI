import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Sign In"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async => auth.hangleSignIn(),
          child: const Text("SignIn with google"),
        ),
      ),
    );
  }
}
