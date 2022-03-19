import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

double defaultMargin = 24.0;
double defaultRadius = 17.0;

Color kPrimaryColor = Color(0xff5C40CC);
Color kBlackColor = Color(0xff1F1449);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGreyColor = Color(0xff9698A9);
Color kGreenColor = Color(0xff0EC3AE);
Color kRedColor = Color(0xffEB70A5);
Color kBackgroundColor = Color(0xffFAFAFA);
Color kInactiveColor = Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailableColor = Color(0xffE0D9FF);
Color kUnavailableColor = Color(0xffEBECF1);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);
TextStyle judulBukuConfirm = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
TextStyle subBukuConfirm = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: Colors.black.withOpacity(0.60),
);
TextStyle methodConfirm = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: Colors.black.withOpacity(0.75),
);
TextStyle categoryTitle = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle featuresTitle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Colors.black.withOpacity(0.87),
);

TextStyle itemTitle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
);

TextStyle itemSubTitle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w300,
);

TextStyle sellerDetail = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
);

TextStyle subDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Colors.black.withOpacity(0.60),
);

TextStyle titleDetail = GoogleFonts.poppins(
  fontSize: 27.sp,
  fontWeight: FontWeight.bold,
);

TextStyle priceDetail = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#5FE675"),
);

TextStyle descriptionDetail = GoogleFonts.poppins(
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
);

TextStyle buttonDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 2,
);

TextStyle appBarTitle = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#1A1A1A"),
);

TextStyle itemTitleTransaction = GoogleFonts.poppins(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle titleTransaction = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle textTransaction = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
);

TextStyle commentTransaction = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

TextStyle titleSuccess = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle textSuccess = GoogleFonts.poppins(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#303030"),
);

TextStyle sellerSuccess = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle orderNumberSuccess = GoogleFonts.poppins(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#D44000"),
);

TextStyle appbarTitle = GoogleFonts.poppins(
  fontSize: 24.51.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle activityTitle = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#303030"),
);

TextStyle moneyActivity = GoogleFonts.poppins(
  fontSize: 39.2.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle lightActivity = GoogleFonts.poppins(
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
  color: HexColor("#303030").withOpacity(0.30),
);

TextStyle statusBook = GoogleFonts.poppins(
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
);

TextStyle subMoneyActivity = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle tabBarTitleActivity = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle itemTitleActivity = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle itemDateActivity = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: HexColor("#303030"),
);

TextStyle titleOnboard = GoogleFonts.poppins(
  fontSize: 27.48.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
);

TextStyle buttonOnboard = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle labelLogin = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#303030"),
);

TextStyle titleLogin = GoogleFonts.poppins(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  color: HexColor("#303030"),
  letterSpacing: 3,
);

TextStyle popularTitleBook = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#333740"),
);

TextStyle popularSubTitleBook = GoogleFonts.poppins(
  fontSize: 10.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#828285"),
);

TextStyle itemNamePayment = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#303030"),
);
