import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoop/ui/onboard/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/ui/onboard/signup_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final logoPintas = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 120.9,
        child: Image.asset('assets/icon_pintas.png'),
      ),
    );

    final loginButton = Container(
      height: 50.h,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor("#3a7bd5"), HexColor("#468df0")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "User Email Log In!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                letterSpacing: 2.5,
              ),
            ),
          ),
        ),
      ),
    );

    final loginBiometric = Container(
      height: 50.h,
      child: RaisedButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor("#3a7bd5"), HexColor("#468df0")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Biometric Log In!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                letterSpacing: 2.5,
              ),
            ),
          ),
        ),
      ),
    );

    final signupLabel = FlatButton(
      child: Text(
        'Register/Sign Up!',
        style: TextStyle(
          color: HexColor("#3a7bd5"),
          fontFamily: 'Poppins',
          fontSize: 17.sp,
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUpScreen();
        }));
      },
    );

    final appDesc = Text(
      'PINTAS',
      style: TextStyle(
        fontSize: 65.sp,
        color: HexColor("#3a7bd5"),
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        letterSpacing: 7.0,
      ),
      textAlign: TextAlign.center,
    );

    final versionLabel = Text(
      'Ver 1.0 ',
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.sp,
      ),
      textAlign: TextAlign.center,
    );

    final copyrightLabel = Text(
      'Copyright @ 2021 PINTAS App',
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.sp,
      ),
      textAlign: TextAlign.center,
    );

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.h),
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    children: <Widget>[
                      logoPintas,
                      SizedBox(
                        height: 15.h,
                      ),
                      appDesc,
                      SizedBox(
                        height: 30.h,
                      ),
                      loginButton,
                      SizedBox(
                        height: 25.h,
                      ),
                      loginBiometric,
                      SizedBox(
                        height: 15.h,
                      ),
                      signupLabel,
                      SizedBox(height: 50.h),
                      Row(
                        children: [
                          Container(child: versionLabel),
                          Container(child: copyrightLabel)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
