import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'package:ms_project/auth/verify.dart';
import 'package:ms_project/drawer.dart';
import 'package:ms_project/home.dart';
import 'package:ms_project/auth/main_page.dart';
import 'package:ms_project/emotions/emotion_detection.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  cameras = await availableCameras();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyHomePage.routeName: (ctx) => MyHomePage(
              moodName: " ",
            ),
        EmotionDetection.routeName: (ctx) => const EmotionDetection(),
        Verification.routeName: (ctx) => const Verification(),
        HiddenDrawer.routeName: (ctx) => HiddenDrawer(
              mood: " ",
            ),
      },
      home: MainPage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
