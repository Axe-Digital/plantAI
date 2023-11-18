import 'package:flutter/material.dart';

showSnackBarMessage( String message, {BuildContext? context}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
