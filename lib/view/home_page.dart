import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/model/camera_manager.dart';
import 'package:plant_ai/view/camera_page.dart';
import 'package:plant_ai/view/plant_page.dart';
import 'package:plant_ai/widgets/main_piece.dart';
import 'package:plant_ai/widgets/my_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> kTabPages = [
      const MainPiece(),
      PlantesScreen(),
    ];

    List<BottomNavigationBarItem> kBottomnavigationItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/fougere.png',
            width: 40,
          ),
          label: 'plantes'),
    ];
    assert(kTabPages.length == kBottomnavigationItems.length);

    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: MyAppBar(),
      body: PageView(children: [kTabPages[_currentTabIndex]]),
      // body: CameraPreview(cameraController),
      // ignore: prefer_const_constructors

      bottomNavigationBar: BottomNavigationBar(
          items: kBottomnavigationItems,
          currentIndex: _currentTabIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: (int index) => setState(() {
                _currentTabIndex = index;
              })),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CameraManager.openCamera().then((camera) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraApp(camera: camera)));
          });
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
