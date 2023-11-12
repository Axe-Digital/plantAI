import 'package:flutter/material.dart';
import 'package:plant_ai/firebase_options.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:plant_ai/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return ChangeNotifierProvider(
      create: (context) => AppStateNotifier(),
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: const SplashScreen(),
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(color: Colors.green),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Colors.black),
            )
          ),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      }),
    );
  }
}
