import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final List<BottomNavigationBarItem> kBottomNavigationBarItems;
  late int currentTabIndex;

  BottomNavigation(
      {super.key,
      required this.kBottomNavigationBarItems,
      required this.currentTabIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.kBottomNavigationBarItems,
      currentIndex: widget.currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          widget.currentTabIndex = index;
        });
      },
    );
  }
}
