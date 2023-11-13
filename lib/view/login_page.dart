// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/register_screen.dart';
import 'package:plant_ai/widgets/my_button.dart';
import 'package:plant_ai/widgets/my_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final formField = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final Auth auth = Auth();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // logo
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    "assets/plantai2.png",
                    height: 140,
                  ),
                ),

                SizedBox(height: height / 12),
                Form(
                  key: formField,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextField(
                          prefix: const Icon(Icons.person),
                          controller: emailController,
                          hintText: 'Email Address or Number',
                          obscureText: false,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-z0-9.a-zA-Z0-9.!#$%&'*+=/=?_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            bool numberValid =
                                RegExp(r'^\+\d{1,3} \d{1,}$').hasMatch(value);
                            if (value.isEmpty) {
                              return "Enter your Address or Number";
                            } else if (!emailValid && !numberValid) {
                              debugPrint(emailController.text);

                              return "Enter Valid Address or Number";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        // password textfield
                        MyTextField(
                          prefix: const Icon(Icons.lock),
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (passwordController.text.length < 6) {
                              return "Password Lenght Should be more than 6 characters";
                            }
                            return null;
                          },
                        ),

                        // sign in button
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height / 12),
                MyButton(
                  title: 'Login',
                  passwordController: passwordController,
                  emailController: emailController,
                  formField: formField,
                ),

                const SizedBox(height: 20),

                // or continue with
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 12),
                // google + facebook sign in buttons
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      IconButton(
                          onPressed: () {
                            auth.hangleSignIn().then((value) {
                              if (auth.userId != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        // ignore: prefer_const_constructors
                                        builder: (context) => HomeScreen()));
                              }
                            });
                          },
                          icon: Image.asset(
                            "assets/logo/google-logo.png",
                            height: 100,
                            width: 100,
                          )),

                      const SizedBox(width: 25),

                      // apple button
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset("assets/logo/facebook-logo.png")),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Not a member?',
                        style:
                            TextStyle(color: Colors.grey[1000], fontSize: 15),
                      ),
                      // SizedBox(width: width / 5),
                      TextButton(
                        onPressed: () {
                          // Image image = Image.asset('image.jpg');Z

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
