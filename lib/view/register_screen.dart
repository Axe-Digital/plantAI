import 'package:flutter/material.dart';
import 'package:plant_ai/view/login_page.dart';

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
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final contactController = TextEditingController();
  bool passToggle = true;
  bool confirmPassToggle = true;
  // final ThemeManager themeManager = Login.themeManager;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    // TextTheme textTheme = Theme.of(context).textTheme;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   title: const Text("Form Page"),
      //   centerTitle: true,
      //   // backgroundColor: Colors.transparent,
      //   // actions: [
      //   //   Switch(
      //   //       value: themeManager.themeMode == ThemeMode.dark,
      //   //       onChanged: (newValue) {
      //   //         themeManager.toggleTheme(newValue);
      //   //       })
      //   // ],
      // ),
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
                    "plantai2.png",
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
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
                    controller: passController,
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
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else if (passController.text.length < 6) {
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
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please entrer re-password";
                      } else if (confirmPassController.text !=
                          passController.text) {
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
                      if (formField.currentState!.validate()) {
                        print("Data Added Successfully");
                        emailController.clear();
                        passController.clear();
                        confirmPassController.clear();
                        firstNameController.clear();
                        lastNameController.clear();
                        contactController.clear();
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
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
                          "Sign Up",
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
