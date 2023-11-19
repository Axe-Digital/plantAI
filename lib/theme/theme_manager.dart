import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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