import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helpborrowbook_page_view.dart';
import 'helpfindbook_page_view.dart';
import 'helpreturnbook_page_view.dart';
import 'helprule_page_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
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
              "Bantuan",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: Column(
            children: [
              SizedBox(height: 53.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HelpFindBook();
                    }));
                  },
                  child: Container(
                    width: 355.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                      color: HexColor("#FFD037").withOpacity(0.70),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18.sp,
                        ),
                        Text(
                          "Cara mencari buku",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 53.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HelpBorrowBook();
                    }));
                  },
                  child: Container(
                    width: 355.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                      color: HexColor("#39A2DB").withOpacity(0.50),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18.sp,
                        ),
                        Text(
                          "Cara meminjam buku",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 53.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HelpReturnBook();
                    }));
                  },
                  child: Container(
                    width: 355.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                      color: HexColor("#C4C4C4"),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18.sp,
                        ),
                        Text(
                          "Cara mengembalikan buku",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 53.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HelpRule();
                    }));
                  },
                  child: Container(
                    width: 355.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                      color: HexColor("#D89C05").withOpacity(0.50),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18.sp,
                        ),
                        Text(
                          "Aturan peminjaman",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
