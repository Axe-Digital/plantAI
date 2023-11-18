import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:plant_ai/auth/auth.dart';
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
  late String? user = auth.userId;
  // late User? user = auth.user;

  @override
  void initState() {
    super.initState();

    print("auth.userId => ${auth.userId}");
    print("user => $user");
    // Définir une temporisation pour afficher la page de splash
    Future.delayed(const Duration(seconds: 1), () {
      switchEvent(); // Naviguer vers la page suivante après la temporisation
    });
  }

  Future<void> switchEvent() async {
    try {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          // ignore: prefer_const_constructors
          PageRouteBuilder(
            transitionDuration: const Duration(
                seconds:
                    2), // Durée de l'animation (500 millisecondes dans cet exemple)
            pageBuilder: (context, animation, secondaryAnimation) =>
                // ignore: prefer_const_constructors
                HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(
                  1.0, 0.0); // Position de départ de l'animation (de la droite)
              var end =
                  Offset.zero; // Position d'arrivée de l'animation (au centre)
              var curve = Curves
                  .ease; // Courbe d'animation (facultatif, vous pouvez choisir une autre courbe)

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      print('eror');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    print("auth.userId2 => ${auth.userId}");
    print("user2 => $user");
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
