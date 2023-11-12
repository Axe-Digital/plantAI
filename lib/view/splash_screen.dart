import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/auth.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  Auth auth = Auth();
  late User? user = auth.auth.currentUser;
  // late User? user = auth.user;

  @override
  void initState() {
    super.initState();
    // Définir une temporisation pour afficher la page de splash
    Future.delayed(const Duration(seconds: 5), () {
      switchEvent(); // Naviguer vers la page suivante après la temporisation
    });
  }

  Future<void> switchEvent() async {
    try {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          // ignore: prefer_const_constructors
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print('eror');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[300],

        // Couleur de fond de la page de splash
        body: Stack(
          children: [
            Center(
              child: Image.asset('assets/plantai.png'),
            ),
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    "from",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Text(
                    "Axe Digital",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 30),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
