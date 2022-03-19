import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/ui/onboard/login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        context.read<AuthCubit>().getCurrentUser(user.uid);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon_pintas.png'))),
            ),
            Text(
              'SCHOOP',
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
