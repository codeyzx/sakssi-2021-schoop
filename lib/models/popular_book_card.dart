import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/models/menu_book.dart';

class PopularBookCard extends StatelessWidget {
  final Menu menu;

  const PopularBookCard({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, left: 8.w, right: 8.w),
      width: 374.w,
      child: Row(
        children: [
          ClipRRect(
              child: Image.network(
            menu.image,
            width: 110.sp,
            height: 110.sp,
          )),
          Container(
            height: 100.h,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  menu.judul,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                Text(menu.penulis),
                Text('${menu.jumlahHalaman} Halaman'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
