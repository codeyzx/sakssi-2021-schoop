import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/ui/library/book/categories_page_digital.dart';
import 'package:schoop/ui/library/book/categories_page_konvensional.dart';

class BookTypePage extends StatelessWidget {
  const BookTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: () => MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: HexColor("#39A2DB"),
                  )),
              title: Text(
                "Pilih Jenis Buku",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
              children: [
                // Box Buku Konvensional ---
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPage()));
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 52.h, horizontal: 33.w),
                    width: 344.w,
                    height: 195.h,
                    decoration: BoxDecoration(
                      color: HexColor("#F6F6F6"),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        topRight: Radius.circular(5.r),
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#000000").withOpacity(0.25),
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                            child: Image.asset(
                          'assets/paperBook.png',
                          width: 162.w,
                          height: 127.h,
                        )),
                        SizedBox(height: 15.h),
                        Container(
                          width: 344.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.w, color: HexColor("#9A9A9A"))),
                          ),
                          child: Center(
                              child: Text(
                            "Buku Konvensional",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                // Box Buku Digital ---
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPageDigital()));
                  },
                  child: Container(
                    width: 344.w,
                    height: 195.h,
                    decoration: BoxDecoration(
                      color: HexColor("#F6F6F6"),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        topRight: Radius.circular(5.r),
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#000000").withOpacity(0.25),
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                            child: Image.asset(
                          'assets/digitalBook.png',
                          width: 162.w,
                          height: 127.h,
                        )),
                        SizedBox(height: 15.h),
                        Container(
                          width: 344.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.w, color: HexColor("#9A9A9A"))),
                          ),
                          child: Center(
                              child: Text(
                            "Buku Digital",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
