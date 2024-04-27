import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? prefix;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    this.prefix, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: prefix,
        suffixIcon: suffixIcon 
      ),
      validator: validator,
    );
  }
}
