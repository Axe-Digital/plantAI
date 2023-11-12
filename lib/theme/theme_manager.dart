import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ThemeManager with ChangeNotifier{

//   ThemeMode _themeMode = ThemeMode.light;

//   get themeMode => _themeMode;

//   toggleTheme(bool isDark){
//     _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
//     notifyListeners();
//   }

// }

class AppStateNotifier with ChangeNotifier {
  bool dark = false;
  // bool dark = true;

  bool get isDarkMode => dark;

  void updateTheme(bool isDarkMode) {
    if (dark != isDarkMode) {
      dark = isDarkMode;
      notifyListeners();
    }
  }
}