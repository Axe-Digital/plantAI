import 'package:flutter/material.dart';
import 'package:plant_ai/main2.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key});

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Second Page"),),
    );
  }
}
