import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpFindBook extends StatelessWidget {
  const HelpFindBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_rounded, color: HexColor("#39A2DB"),)),
            title: Text("Cara Mencari Buku", style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: ListView(
            children: [
              SizedBox(height: 40.h,),
              Padding(
                padding: EdgeInsets.only(left: 21.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextHeader("Cara mencari buku dengan search"),
                   Padding(
                     padding: EdgeInsets.only(left: 17.w, top: 10.h),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextList("1. lorem ipsum"),
                            SizedBox(height: 5.h,),
                            buildTextList("2. lorem ipsum dolor"),
                            SizedBox(height: 5.h,),
                            buildTextList("3. lorem ipsum dolor sit"),
                            SizedBox(height: 5.h,),
                            buildTextList("4. lorem ipsum dolor sit amet"),
                            SizedBox(height: 5.h,),
                            buildTextList("5. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vel mattis risus, eget congue diam. Nunc egestas tellus vel lorem varius fringilla."),
                          ],
                        ),
                   ),
                    SizedBox(height: 40.h,),
                    buildTextHeader("Cara mencari buku dengan kategori"),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextList("1. lorem ipsum"),
                          SizedBox(height: 5.h,),
                          buildTextList("2. lorem ipsum dolor"),
                          SizedBox(height: 5.h,),
                          buildTextList("3. lorem ipsum dolor sit"),
                          SizedBox(height: 5.h,),
                          buildTextList("4. lorem ipsum dolor sit amet"),
                          SizedBox(height: 5.h,),
                          buildTextList("5. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vel mattis risus, eget congue diam. Nunc egestas tellus vel lorem varius fringilla."),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    buildTextHeader("Cara mencari buku digital"),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextList("1. lorem ipsum"),
                          SizedBox(height: 5.h,),
                          buildTextList("2. lorem ipsum dolor"),
                          SizedBox(height: 5.h,),
                          buildTextList("3. lorem ipsum dolor sit"),
                          SizedBox(height: 5.h,),
                          buildTextList("4. lorem ipsum dolor sit amet"),
                          SizedBox(height: 5.h,),
                          buildTextList("5. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vel mattis risus, eget congue diam. Nunc egestas tellus vel lorem varius fringilla."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Text buildTextList(String textList) {
    return Text(textList, style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(0.87),
                          fontWeight: FontWeight.w500,
                        ),);
  }

  Text buildTextHeader(String textHeader) {
    return Text(textHeader, style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black.withOpacity(0.87),
                    fontWeight: FontWeight.w700,
                  ),);
  }
}
