import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:plant_ai/firebase_options.dart';
import 'package:plant_ai/model/camera_manager.dart';
import 'package:plant_ai/model/model.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/plant_page.dart';
import 'package:plant_ai/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:plant_ai/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await CameraManager.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateNotifier>(
          create: (_) => AppStateNotifier(),
        ),
        ChangeNotifierProvider<Model>(create: (_) => Model()),

        // Ajoutez d'autres providers ici si nécessaire
      ],
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: const SplashScreen(),
          theme: ThemeData.light().copyWith(
              appBarTheme: AppBarTheme(color: Colors.grey[200]),
              scaffoldBackgroundColor: Colors.grey[200]),
          darkTheme: ThemeData.dark().copyWith(
              buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
              scaffoldBackgroundColor: Color(0xFF424242),
              textTheme: ThemeData.dark().textTheme.copyWith(
                    bodyLarge: const TextStyle(color: Colors.black),
                  )),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      }),
    );
  }
}
