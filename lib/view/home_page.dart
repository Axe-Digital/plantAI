import 'package:flutter/material.dart';
import 'package:plant_ai/view/camera.dart';
import 'package:plant_ai/widgets/my_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_ai/auth/authentification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  final GoogleSignIn googleSignIn = Auth().googleSignIn;


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: null,
                decoration: const InputDecoration(
                  hintText: 'Rechercher...',
                  suffixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  // Gérer la soumission de la recherche ici
                  print('Recherche soumise: $value');
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              width: width * 0.7,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Welcome Back, ${auth.firstName() ?? ""} ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Camera(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await auth.handleSignOut();
      }),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final kBottomNavBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Tab1'),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
  ];

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: kBottomNavBarItems,
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentTabIndex = index;
        });
      },
    );
  }
}
