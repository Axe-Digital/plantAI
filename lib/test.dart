import 'package:flutter/material.dart';
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/login_page.dart';
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

  bool _onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _onLastPage = (index == 2);
                  // print(_onLastPage);
                });
              },
              children: [
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.yellow,
                ),
                Container(
                  color: Colors.green,
                )
              ],
            ),
          ],
        ),
        bottomSheet: Container(
            height: height * 0.10,
            decoration: const BoxDecoration(color: Colors.white),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: ),
            // color: Colors.red,
            child: !_onLastPage
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(2);
                        },
                        child: const Text("SKIP"),
                      ),
                      SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: WormEffect(
                              spacing: 16,
                              dotColor: Colors.black26,
                              activeDotColor: Colors.teal.shade700),
                          onDotClicked: (index) => _controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn)),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text('NEXT'),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.teal.shade700,
                    child: TextButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  // ignore: prefer_const_constructors
                                  builder: ((context) => LoginScreen())));
                        },
                        style: TextButton.styleFrom(
                            elevation: 0.4,
                            // shape: RoundedRectangleBorder(),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal.shade700,
                            minimumSize: const Size.fromHeight(80)),
                        child: const Text("Get Started",
                            style: TextStyle(
                              fontSize: 24,
                            ))),
                  )));
  }
}
