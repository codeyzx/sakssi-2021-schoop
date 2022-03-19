import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_categories.dart';

class CategoriesCard extends StatelessWidget {
  final MenuCategories menuCategories;

  const CategoriesCard({Key? key, required this.menuCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 120.h,
      margin: EdgeInsets.only(top: 30.h, left: 39.w, right: 39.w),
      decoration: BoxDecoration(
        color: HexColor("#ECF2FE"),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: 335.w,
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  image: NetworkImage(menuCategories.image)),
            ),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                menuCategories.nama,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
