import 'package:flutter/material.dart';
import 'package:plant_ai/model/camera_manager.dart';
import 'package:plant_ai/view/camera_page.dart';
import 'package:plant_ai/view/plant_page.dart';
import 'package:plant_ai/view/main_piece.dart';
import 'package:plant_ai/widgets/my_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final int currentTabIndex;
  const HomeScreen({super.key, required this.currentTabIndex});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.currentTabIndex;
  }

  @override
  void dispose() {
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> kTabPages = [
      const MainPiece(),
      const PlantesScreen(),
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
      resizeToAvoidBottomInset: false,
      body: kTabPages[_currentTabIndex],
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
