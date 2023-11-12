import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_ai/firebase_options.dart';
import 'package:plant_ai/myfsecond_page.dart';

import 'myfirst_page.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Auth',
      home: MyAppz(),
    );
  }
}

class MyAppz extends StatelessWidget {
  const MyAppz({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // L'identifiant d'utilisateur de l'utilisateur connecté
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? userUid = "ojo";
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late String? darrel;
  // Stream<FileResponse>? fileStream;

  @override
  void initState() {
    super.initState();
    userId();
    Future.delayed(const Duration(seconds: 5), () {
      Switch();
    });
  }

  Future<void> userId() async {
    try {
      user = auth.currentUser;
      darrel = 'crc';
    } catch (e) {
      print('Error');
    }
  }

  // Google Sign In
  Future<void> hangleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await auth.signInWithCredential(credential);
        user = auth.currentUser;
        Switch();
      }
    } catch (e) {
      print("Error signing in with google $e");
    }
  }

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print("error signing out: $e");
    }
  }

  Future<void> Switch() async {
    try {
      if (auth.currentUser != null) {
        Navigator.push(
          context,
          // ignore: prefer_const_constructors
          MaterialPageRoute(builder: (context) => MyFirstPage()),
        );
      }
    } catch (e) {
      print('eror');
    }

    // auth.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     // User is logged in
    //     Navigator.pushReplacement(
    //       context,
    //       // ignore: prefer_const_constructors
    //       MaterialPageRoute(builder: (context) => MyFirstPage()),
    //     );
    //   } else {
    //     // User is not logged in
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const MySecondPage()),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // User? user = auth.currentUser!;
    // darrel = "crcr";
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Google Auth'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Si l'identifiant d'utilisateur est stocké, authentifiez l'utilisateur automatiquement
              if (user == null) ...[
                const Text('Authentifié automatiquement'),
                ElevatedButton(
                  child: const Text('Se connecter'),
                  onPressed: () {
                    hangleSignIn();
                    // Switch();
                    // print(userUid);
                  },
                ),
              ],
              if (user != null) ...[
                const Text('Deja Authentifié '),
                Text(auth.currentUser!.displayName ?? 'cec'),
              ]
              // Sinon, affichez un bouton de connexion
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await handleSignOut();
          },
          child: const Icon(Icons.delete),
        ));
  }
}
