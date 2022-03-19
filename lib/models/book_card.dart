import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/models/menu_book.dart';

class BookCard extends StatelessWidget {
  final Menu menu;

  const BookCard({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324.w,
      height: 196.h,
      margin: EdgeInsets.only(left: 33.w, right: 34.w, top: 36.h),
      child: Container(
        width: 293.w,
        height: 176.h,
        margin: EdgeInsets.only(left: 15.w, right: 13.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.sp,
              color: HexColor("#6F6F6F"),
            ),
          ),
        ),
        child: Row(
          children: [
            //image
            Container(
              width: 105.w,
              height: 173.h,
              margin: EdgeInsets.only(bottom: 18.h, right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.50),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    menu.image,
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              width: 174.w,
              height: 153.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Judul
                  Container(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Text(
                        menu.judul,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  Container(
                    width: 138.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //date
                        Text(
                          menu.tahunTerbit,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.60),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${menu.jumlahHalaman} Halaman',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.60),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Penulis : ${menu.penulis}',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.60),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Penerbit : ${menu.penerbit}',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.60),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Genre : ${menu.categories}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.60),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
