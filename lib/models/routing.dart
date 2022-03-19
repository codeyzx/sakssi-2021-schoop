import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/ui/onboard/login_screen.dart';

class Routing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return LoginScreen();
            } else {
              return NavBar();
            }
          }),
    );
  }
}
