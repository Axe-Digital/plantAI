import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_ai/view/login_page.dart';
import 'package:plant_ai/view/register_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  // final PageController controller;
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool _isVisible = false;
  bool _onLastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _onLastPage = (index == 2);
                _isVisible = (index == 2);
                // print(_onLastPage);
              });
            },
            children: [
              Container(
                color: Colors.white,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 201.4,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Text(
                        "Step into a World of Learning Excellence",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Opacity(
                          opacity: 0.3,
                          child: Text(
                            "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan ",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          )),
                    ),
                    SizedBox(height: height * 0.20)
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 201.4,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Text(
                        "Step into a World of Learning Excellence",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Opacity(
                          opacity: 0.3,
                          child: Text(
                            "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan ",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          )),
                    ),
                    SizedBox(height: height * 0.20)
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 201.4,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Text(
                        "Step into a World of Learning Excellence",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.9),
                      child: const Opacity(
                          opacity: 0.3,
                          child: Text(
                            "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan ",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          )),
                    ),
                    SizedBox(height: height * 0.20)
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: const FractionalOffset(0.98, 0.05),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: _isVisible,
                    child: GestureDetector(
                      onTap: () {
                        _controller.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "BACK",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "SKIP",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const FractionalOffset(0.5, 0.7),
            child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.teal.shade700),
                onDotClicked: (index) => _controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn)),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.1),
            child: !_onLastPage
                ? Align(
                    alignment: const FractionalOffset(0.5, 0.9),
                    child: GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.green, border: Border.symmetric()),
                          child: const Center(
                              child: Text(
                            'NEXT',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                  )
                : Align(
                    alignment: const FractionalOffset(0.5, 0.94),
                    child: SizedBox(
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  )),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: width * 0.9,
                            height: 40,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Colors.orange),
                                  ),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  )),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
