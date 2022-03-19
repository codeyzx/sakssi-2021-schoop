// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/ui/food/food_detail_page.dart';
import 'package:schoop/ui/food/food_items.dart';
import 'package:schoop/ui/library/book/book_homepage.dart';
import 'package:schoop/ui/payment/payment_items.dart';
import 'package:schoop/ui/services/service_detail_page.dart';
import 'package:schoop/ui/services/service_items_page.dart';
import 'package:schoop/ui/shop/shop_detail_page.dart';
import 'package:schoop/ui/shop/shop_items_page.dart';
import 'news_info.dart';
import 'package:schoop/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imageList = imagesItem;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference food = FirebaseFirestore.instance.collection('food');
    CollectionReference shop = FirebaseFirestore.instance.collection('shop');
    CollectionReference services =
        FirebaseFirestore.instance.collection('services');
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: ListView(
              children: [
                // Header
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is AuthSuccess) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: users
                            .where('nis', isEqualTo: state.user.nis)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: (snapshot.data!)
                                  .docs
                                  .map(
                                    (e) => Container(
                                      width: 411.w,
                                      height: 143.h,
                                      decoration: BoxDecoration(
                                        color: HexColor("#303030"),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.w,
                                            top: 30.h,
                                            right: 18.w,
                                            bottom: 15.h),
                                        child: Container(
                                          //container untuk image nama welcome back
                                          width: 368.w,
                                          height: 60.h,
                                          child: Row(
                                            children: [
                                              Container(
                                                //image user
                                                width: 65.w,
                                                height: 65.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: e['picture'] == ""
                                                        ? NetworkImage(
                                                            'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                                                          )
                                                        : NetworkImage(
                                                            e['picture']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15.w),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 270.w,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          "Hello, ${e['name']} ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 18.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Welcome back!",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 24.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  } else {
                    return SizedBox();
                  }
                }),
                SizedBox(height: 20.h),

                // Features
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "Features",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 72.w, right: 75.w),
                  child: Container(
                    width: 250.w,
                    height: 172.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          //row pertama untuk feature
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodItems()));
                                }, //function untuk pindah page
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        //container background warna image
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#D44000"),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("#004365")
                                                  .withOpacity(0.35),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          //icon image nanti diisi pake variable disini
                                          child: Image.asset(
                                            "assets/cookies.png",
                                            width: 23.w,
                                            height: 23.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Food",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopItemsPage()));
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#464660"),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("#004365")
                                                  .withOpacity(0.35),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/shop.png",
                                            width: 23.w,
                                            height: 23.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Shop",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceItemsPage()));
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#0C4271"),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("#004365")
                                                  .withOpacity(0.35),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/services.png",
                                            width: 23.w,
                                            height: 23.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Services",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          //row kedua untuk feature
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentItems()));
                                }, //function untuk pindah page
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        //container background warna image
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#FFAB4C"),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("#004365")
                                                  .withOpacity(0.35),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          //icon image nanti diisi pake variable disini
                                          child: Image.asset(
                                            "assets/coin.png",
                                            width: 23.w,
                                            height: 23.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Payment",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookHomePage()));
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#39A2DB"),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("#004365")
                                                  .withOpacity(0.35),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/books.png",
                                            width: 23.w,
                                            height: 23.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Library",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => buildSheet(),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.r),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 81.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/more-icon.png",
                                            width: 90.w,
                                            height: 90.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "More",
                                        style: featuresTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                //news & information
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "News & Information",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 167.h,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 900),
                    enlargeCenterPage: true,
                  ),
                  items: imageList
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.network(
                                  e,
                                  width: 274.w,
                                  height: 167.h,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20.h),

                //food & beverage
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "Foods & Beverages",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: food.limit(6).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: (snapshot.data!)
                                      .docs
                                      .map((e) => Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 11.w),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FoodDetailPage(
                                                                    e.id,
                                                                    e['image'],
                                                                    e['name'],
                                                                    e['price'],
                                                                    e['stock'],
                                                                    e['seller'],
                                                                    e['seller_number'],
                                                                    e['desc'])));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        child: Image.network(
                                                          e['image'],
                                                          width: 158.w,
                                                          height: 97.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['name'],
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['seller'],
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              "Rp " +
                                                                  e['price']
                                                                      .toString(),
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                //shop
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "Shop",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: shop.limit(6).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: (snapshot.data!)
                                      .docs
                                      .map((e) => Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 11.w),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ShopDetailPage(
                                                                    e.id,
                                                                    e['image'],
                                                                    e['name'],
                                                                    e['price'],
                                                                    e['stock'],
                                                                    e['seller'],
                                                                    e['seller_number'],
                                                                    e['desc'])));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        child: Image.network(
                                                          e['image'],
                                                          width: 158.w,
                                                          height: 97.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['name'],
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['seller'],
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              "Rp " +
                                                                  e['price']
                                                                      .toString(),
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                //services
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "Services",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: services.limit(6).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: (snapshot.data!)
                                      .docs
                                      .map((e) => Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 11.w),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ServiceDetailPage(
                                                                    e.id,
                                                                    e['image'],
                                                                    e['name'],
                                                                    e['price'],
                                                                    e['stock'],
                                                                    e['seller'],
                                                                    e['seller_number'],
                                                                    e['desc'])));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        child: Image.network(
                                                          e['image'],
                                                          width: 158.w,
                                                          height: 97.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['name'],
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              e['seller'],
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 148.w,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              "Rp " +
                                                                  e['price']
                                                                      .toString(),
                                                              style:
                                                                  itemSubTitle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                //what's happening now items slide
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "What's happening now?",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 167.h,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 900),
                    enlargeCenterPage: true,
                  ),
                  items: imageList
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.network(
                                  e,
                                  width: 274.w,
                                  height: 167.h,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20.h),

                //tips & trick
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Text(
                    "Tips & Trick",
                    style: categoryTitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: InkWell(
                    onTap: () async {
                      final url =
                          'https://rakyatnesia.com/08/08/51199/kata-kata-motivasi-dan-bijak-elon-musk-pemilik-tesla-dan-space-x/';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceWebView: true,
                          forceSafariVC: true,
                          enableJavaScript: true,
                        );
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.network(
                            "https://i2.wp.com/rakyatnesia.com/wp-content/uploads/2021/08/elon-musk-3.jpg?resize=701%2C419&ssl=1",
                            width: 158.w,
                            height: 97.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kata – Kata Motivasi",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "08-08-2021",
                              style: itemSubTitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Moch Akbar Fitrianto",
                              style: itemSubTitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "69 minutes read",
                              style: itemSubTitle,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet() {
    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          builder: (_, controller) => Container(
                decoration: BoxDecoration(
                  color: HexColor("#F6F6F6"),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 9.h,
                    ),
                    Center(
                      child: Container(
                        width: 62.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.r),
                          color: HexColor("#C4C4C4").withOpacity(0.70),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Food and Shop",
                            style: itemTitleActivity,
                          ),
                          SizedBox(height: 9.h),
                          //food
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodItems()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#D44000"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/cookies.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Food & Beverage",
                                        style: itemTitle,
                                      ),
                                      Text(
                                        "Beli makanan atau cemilan.",
                                        style: itemSubTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 9.h),
                          //shop
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopItemsPage()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#464660"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/shop.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Shop",
                                        style: itemTitle,
                                      ),
                                      Text(
                                        "Beli barang kebutuhanmu.",
                                        style: itemSubTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Services",
                            style: itemTitleActivity,
                          ),
                          SizedBox(height: 9.h),
                          //services
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceItemsPage()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#0C4271"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/services.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Services",
                                        style: itemTitle,
                                      ),
                                      Text(
                                        "Temukan jasa yang dibutuhkan.",
                                        style: itemSubTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Payment",
                            style: itemTitleActivity,
                          ),
                          SizedBox(height: 9.h),
                          //Bayar Spp
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentItems()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#FFAB4C"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/coin.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bayar SPP",
                                        style: itemTitle,
                                      ),
                                      Text(
                                        "Bayar SPP sekolah.",
                                        style: itemSubTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 9.h),
                          //Bayar seragam
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentItems()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#654CFF"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/shirt.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bayar Seragam",
                                        style: itemTitle,
                                      ),
                                      Text(
                                        "Bayar seragam sekolah.",
                                        style: itemSubTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Entertaiment",
                            style: itemTitleActivity,
                          ),
                          SizedBox(height: 9.h),
                          //Library
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookHomePage()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //container background warna image
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#39A2DB"),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Center(
                                      //icon image nanti diisi pake variable disini
                                      child: Image.asset(
                                        "assets/books.png",
                                        width: 23.w,
                                        height: 23.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Library",
                                        style: itemTitle,
                                      ),
                                      Container(
                                          width: 245.w,
                                          height: 36.h,
                                          child: Text(
                                            "Baca buku konvensional & digital hingga pengembalian buku.",
                                            style: itemSubTitle,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
