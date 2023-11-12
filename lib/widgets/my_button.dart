import 'package:flutter/material.dart';
import 'package:plant_ai/view/home_page.dart';

class MyButton extends StatelessWidget {
  final GlobalKey<FormState> formField;
  final TextEditingController passWordController;
  final TextEditingController userNameController;
  final String title;
  final String user;

  const MyButton(
      {super.key,
      required this.user,
      required this.formField,
      required this.passWordController,
      required this.userNameController,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (formField.currentState!.validate()) {
          print("Data Added Successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          // passWordController.clear();
          // userNameController.clear();
          // lastNameController.clear();
          // contactController.clear();
        }
      },
      child: Container(
        height: 50,
        width: width * 0.6,
        decoration: BoxDecoration(
            color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
