import 'package:flutter/material.dart';

dynamic showSnackBarMessage( String message, {BuildContext? context}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
