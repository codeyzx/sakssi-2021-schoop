// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/ui/schoop/search/search_page.dart';
import 'package:schoop/ui/schoop/search/search_page_shop.dart';
import 'package:schoop/ui/shop/shop_detail_page.dart';

class ShopItemsPage extends StatefulWidget {
  const ShopItemsPage({Key? key}) : super(key: key);

  @override
  _ShopItemsPageState createState() => _ShopItemsPageState();
}

class _ShopItemsPageState extends State<ShopItemsPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference shop = FirebaseFirestore.instance.collection('shop');
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor("#F7F7FA"),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: HexColor("#464660"),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Beli apa ya?",
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        color: HexColor("#F1E9E5"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 0,
                    floating: false,
                    pinned: true,
                    snap: false,
                    expandedHeight: 133.h,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: HexColor("#464660"),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 45.h),
                            width: 377.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    bottom: 7.h,
                                  ),
                                  hintText: ("penghapus..."),
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: Colors.black.withOpacity(0.50),
                                      fontWeight: FontWeight.w400),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchPageShop()));
                                    },
                                    child: Image.asset("assets/Search.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: shop.snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: (snapshot.data!)
                                  .docs
                                  .map((e) => Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 18.h,
                                                  left: 19.w,
                                                  right: 16.w),
                                              child: InkWell(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ShopDetailPage(
                                                        e.id,
                                                        e['image'],
                                                        e['name'],
                                                        e['price'],
                                                        e['stock'],
                                                        e['seller'],
                                                        e['seller_number'],
                                                        e['desc']);
                                                  }));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 154.w,
                                                      height: 154.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: HexColor(
                                                                    "#864000")
                                                                .withOpacity(
                                                                    0.15),
                                                            offset:
                                                                Offset(0, 5),
                                                            blurRadius: 15,
                                                          ),
                                                        ],
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              e['image']),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      width: 207.w,
                                                      height: 154.h,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e['name'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            e['seller'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Rp",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                              Text(
                                                                e['price']
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            e['desc'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12.sp,
                                                              color: HexColor(
                                                                  "#1A1A1A"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
