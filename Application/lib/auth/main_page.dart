import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ms_project/auth/auth_page.dart';
import 'package:ms_project/drawer.dart';

class MainPage extends StatelessWidget {
  String mood = " ";
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HiddenDrawer(
              mood: mood,
            );
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
