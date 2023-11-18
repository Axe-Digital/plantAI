import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/services/camera_manager.dart';
import 'package:plant_ai/view/camera_page.dart';
import 'package:plant_ai/widgets/main_piece.dart';
import 'package:plant_ai/widgets/my_app_bar.dart';
import 'package:plant_ai/services/camera_manager.dart';
// import 'package:plant_ai/main.dart' as M;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    // CameraManager.initialize();
    // .then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         print("Access was denied");
    //         // Handle access errors here.
    //         break;
    //       default:
    //         print(e.description); // Handle other errors here.
    //         break;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = CameraManager.cameraController;
    final List<Widget> kTabPages = [
      const MainPiece(),
      Center(
          child: Image.asset(
        "assets/fougere.png",
        width: 50,
      )),
    ];

    final List<BottomNavigationBarItem> kBottomnavigationItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/fougere.png',
            width: 70,
          ),
          label: 'plantes'),
    ];
    assert(kTabPages.length == kBottomnavigationItems.length);

    BottomNavigationBar bottomNavBar = BottomNavigationBar(
        items: kBottomnavigationItems,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => setState(() {
              currentTabIndex = index;
            }));

    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: MyAppBar(),
      // body: kTabPages[currentTabIndex],
      body: CameraPreview(cameraController),
      // ignore: prefer_const_constructors
      bottomNavigationBar: bottomNavBar,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CameraApp()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.camera_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      // onPressed: () {

      // }
      // }),
    );
  }
}
