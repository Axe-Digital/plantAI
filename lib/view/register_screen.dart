import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/login_page.dart';
import 'package:plant_ai/widgets/snackbar_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final contactController = TextEditingController();
  bool passToggle = true;
  bool confirmPassToggle = true;
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
  final db = FirebaseFirestore.instance;
  final auth = Auth();
  late UserCredential? credential;

  void submit() async {
    if (formField.currentState!.validate()) {
      try {
        await auth.createUserWithEmailAndPassword(
            emailController.text, passwordController.text, showSnackBarMessage);
        final user = Firestore(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            number: contactController.text,
            email: emailController.text,
            password: passwordController.text);
        Firestore.saveUserName = firstNameController.text;
        user.uploadData().then((value) {
          if (auth.userId != null) {
            Navigator.push(
                context,
                // ignore: prefer_const_constructors
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        });
      } catch (e) {
        print("Erreur lors de la recuperation de l'utilisateur $e");
      }
      print("Data Added Successfully");
      // emailController.clear();
      // passwordController.clear();
      // confirmPassController.clear();
      // firstNameController.clear();
      // lastNameController.clear();
      // contactController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: width * 0.9),
            child: Form(
              key: formField,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/plantai2.png",
                    height: 150,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: width * 0.44),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            bool emailValid =
                                RegExp(r"^[a-zA-Z\s]+$").hasMatch(value!);
                            if (value.isEmpty) {
                              return "Enter your first name";
                            } else if (!emailValid) {
                              return "Enter Valid first name";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: width * 0.44),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            bool emailValid =
                                RegExp(r"^[a-zA-Z\s]+$").hasMatch(value!);
                            if (value.isEmpty) {
                              return "Enter your last name";
                            } else if (!emailValid) {
                              return "Enter Valid last name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: contactController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    validator: (value) {
                      bool emailValid =
                          RegExp(r'^\+\d{1,3} \d{1,}$').hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter your phone number";
                      } else if (!emailValid) {
                        return "Enter Valid phone number (You must start with your code country)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-z0-9.a-zA-Z0-9.!#$%&'*+=/=?_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter Email";
                      } else if (!emailValid) {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                        labelText: "PassWord",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else if (passwordController.text.length < 6) {
                        return "Password Lenght Should be more than 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPassController,
                    obscureText: confirmPassToggle,
                    decoration: InputDecoration(
                        labelText: "Confirm PassWord",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              confirmPassToggle = !confirmPassToggle;
                            });
                          },
                          child: Icon(confirmPassToggle
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please entrer re-password";
                      } else if (confirmPassController.text !=
                          passwordController.text) {
                        return "Password Doesn't Match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      submit();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const LoginScreen()),
                      // );
                    },
                    child: Container(
                      height: 50,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20)),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
