// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/onboard/login_screen.dart';
import 'package:schoop/ui/onboard/signup_screen.dart';

class OnBoardingSchoopPage extends StatefulWidget {
  const OnBoardingSchoopPage({Key? key}) : super(key: key);

  @override
  _OnBoardingSchoopPageState createState() => _OnBoardingSchoopPageState();
}

class _OnBoardingSchoopPageState extends State<OnBoardingSchoopPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor("#F7F7FA"),
            body: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                color: HexColor("#F7F7FA"),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/outline-bg.png",
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 78.15.h,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/onboard-img.png",
                      width: 277.w,
                      height: 205.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 75.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 74.w, right: 75.w),
                    child: Text(
                      "Selamat Datang di Schoop",
                      style: titleOnboard,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Padding(
                    padding: EdgeInsets.only(left: 74.w, right: 75.w),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras suscipit neque at mi eleifend, in fermentum mi pellentesque. Maecenas quis velit faucibus, congue magna eu, mattis odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam laoreet enim odio, ut",
                      style: itemDateActivity,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Container(
                    width: 281.w,
                    height: 42.h,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              print("click register");
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpScreen();
                              }));
                            },
                            child: Container(
                              width: 155.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                color: HexColor("#474747").withOpacity(0.50),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                  child: Text(
                                "Register",
                                style: buttonOnboard,
                              )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("click signin");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: Container(
                            width: 147.w,
                            height: 42.h,
                            decoration: BoxDecoration(
                              color: HexColor("#F2C94C"),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                                child: Text(
                              "Sign in",
                              style: itemTitleActivity,
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
