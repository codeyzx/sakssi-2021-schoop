import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpReturnBook extends StatelessWidget {
  const HelpReturnBook({Key? key}) : super(key: key);

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
            title: Text("Cara Mengembalikan Buku", style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 21.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                buildText("1. Pergi ke halaman Activity"),
                SizedBox(height: 10.h),
                buildText("2. Pilih bagian Sedang dibaca"),
                SizedBox(height: 10.h),
                buildText("3. Pilih buku yang akan dikembalikan"),
                SizedBox(height: 10.h),
                buildText("4. Klik kembalikan buku"),
                SizedBox(height: 10.h),
                buildText("5. Kembalikan buku ke petugas perpustakaan"),
                SizedBox(height: 10.h),
                buildText("6. Scan QR code pada aplikasi"),
                SizedBox(height: 10.h),
                buildText("7. Anda selesai mengembalikan buku"),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Text buildText(String text) {
    return Text(text, style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: Colors.black.withOpacity(0.87),
                fontWeight: FontWeight.w700,
              ),);
  }
}
