import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpBorrowBook extends StatelessWidget {
  const HelpBorrowBook({Key? key}) : super(key: key);

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
              title: Text("Cara Meminjam Buku", style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(left: 21.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  buildText("1. Cari buku yang ingin Anda baca"),
                  SizedBox(height: 10.h),
                  buildText("2. Klik tombol tambah ke keranjang"),
                  SizedBox(height: 10.h),
                  buildText("3. Ceklis buku yang ingin dipinjam pada halaman keranjang"),
                  SizedBox(height: 10.h),
                  buildText("4. Pilih metode peminjaman, Anda bisa membaca di perpustakaan sekolah atau dibaca di rumah"),
                  SizedBox(height: 10.h),
                  buildText("5. Jika ingin membaca di perpustakaan, pilih terlebih dahulu kursi yang tersedia"),
                  SizedBox(height: 10.h),
                  buildText("6. Klik tombol pilih metode, selanjutnya akan muncul QR code yang harus Anda scan di meja petugas perpustakaan"),
                  SizedBox(height: 10.h),
                  buildText("7. Jika sudah muncul halaman berhasil meminjam, maka anda sudah bisa membaca buku tersebut"),
                  SizedBox(height: 10.h),
                  buildText("8. Jangan lupa kembalikan buku sebelum tenggat waktu yang sudah diberikan"),
                ],
              ),
            ),
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
