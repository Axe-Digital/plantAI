import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/view/on_boarding_page.dart';
import 'package:plant_ai/view/home_page.dart';
// import 'package:plant_ai/view/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key,});

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
    Future.delayed(const Duration(seconds: 3), (() => switchEvent()));
  }

  Future<void> switchEvent() async {
    try {
      if (Auth.userId != null && Auth.currentUser!.emailVerified) {
        Navigator.of(context).pushReplacement(
          // ignore: prefer_const_constructors
          PageRouteBuilder(
            transitionDuration: const Duration(
                seconds:
                    3), // Durée de l'animation (500 millisecondes dans cet exemple)
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Gif(
          image: const AssetImage("assets/splash.gif"),
          controller: _controller,
          //fps: 30,
          //duration: const Duration(seconds: 3),
          autostart: Autostart.no,
          // placeholder: (context) => const Text('Loading...'),
          onFetchCompleted: () {
            _controller.reset();
            _controller.forward();
          },
        ),
      ),
    );
  }
}
