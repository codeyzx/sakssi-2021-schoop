import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/schoop/profile/help_page_view.dart';

class HelpSchoopPage extends StatefulWidget {
  const HelpSchoopPage({Key? key}) : super(key: key);

  @override
  _HelpSchoopPageState createState() => _HelpSchoopPageState();
}

class _HelpSchoopPageState extends State<HelpSchoopPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: HexColor("#F7F7FA"),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 348.h,
                  color: HexColor("#0C4271"),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 31.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 31.w),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          Center(
                            child: Text(
                              "Pusat Bantuan",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                          child: Image.asset(
                        "assets/call-img.png",
                        width: 260.w,
                        height: 220.h,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(height: 5.h),
                      Center(
                        child: Text(
                          "24/7 Customer support",
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    "Apa yang ingin dibantu?",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.87),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    children: [
                      ButtonTheme(
                        minWidth: 361.w,
                        height: 57.h,
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Text(
                            "Cara menjual sesuatu",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ButtonTheme(
                        minWidth: 361.w,
                        height: 57.h,
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Text(
                            "Cara membeli sesuatu",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ButtonTheme(
                        minWidth: 361.w,
                        height: 57.h,
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HelpPage();
                            }));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Text(
                            "Tentang perpustakaan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ButtonTheme(
                        minWidth: 361.w,
                        height: 57.h,
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Text(
                            "Cara melaporkan bug",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
