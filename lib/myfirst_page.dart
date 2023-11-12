import 'package:flutter/material.dart';
import 'package:plant_ai/main2.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({super.key});

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  @override
  Widget build(BuildContext context) {
        return  Scaffold(
      body: Center(child: Text("First Page"),),
      appBar: AppBar(
        title: Text("iinir"),
      ),
    );
  }
}
