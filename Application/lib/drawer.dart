import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:ms_project/auth/logout.dart';
import 'package:ms_project/emotions/emotion_detection.dart';
import 'package:ms_project/home.dart';

class HiddenDrawer extends StatefulWidget {
  static const routeName = '/hidden-drawer';
  String mood = ' ';

  HiddenDrawer({Key? key, required this.mood}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home Page',
          baseStyle: const TextStyle(
            fontSize: 16,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        MyHomePage(
          moodName: widget.mood,
        ),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Mood Detector',
          baseStyle: const TextStyle(
            fontSize: 16,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const EmotionDetection(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Logout',
          baseStyle: const TextStyle(
            fontSize: 16,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Logout(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: const Color.fromRGBO(100, 223, 223, 0.7),
      initPositionSelected: 0,
      isDraggable: true,
      slidePercent: 55,
    );
  }
}
