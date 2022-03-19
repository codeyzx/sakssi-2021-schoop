import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpRule extends StatelessWidget {
  const HelpRule({Key? key}) : super(key: key);

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
            title: Text("Aturan Peminjaman", style: GoogleFonts.poppins(
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
                SizedBox(height: 40.h,),
                buildText("1. Pengguna Aplikasi Pintas diwajibkan mengisi data diri dengan valid pada bagian daftar akun"),
                SizedBox(height: 10.h),
                buildText("2. Peminjam buku disarankan mengembalikan buku sebelum tenggat waktu, jika terlambat maka akan dikenakan denda"),
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
