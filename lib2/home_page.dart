import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: auth.handleSignOut, icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Text(FirebaseAuth.instance.currentUser!.email.toString()),
      ),
    );
  }
}
