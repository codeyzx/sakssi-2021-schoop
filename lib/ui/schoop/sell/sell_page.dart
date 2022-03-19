import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/services/transaction_service_food.dart';
import 'package:schoop/services/transaction_service_services.dart';
import 'package:schoop/services/transaction_service_shop.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/schoop/sell/food_form.dart';
import 'package:schoop/ui/schoop/sell/services_form.dart';
import 'package:schoop/ui/schoop/sell/shop_form.dart';

class SellerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference hfood = firestore.collection('history_food');
    CollectionReference hShop = firestore.collection('history_shop');
    CollectionReference sShop = firestore.collection('history_services');
    final Query historyFood = hfood.where('status', isEqualTo: false);
    final Query historyShop = hShop.where('status', isEqualTo: false);
    final Query historyServices = sShop.where('status', isEqualTo: false);

    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(133.h),
              child: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: HexColor("#303030"),
                flexibleSpace: Column(
                  children: [
                    SizedBox(
                      height: 71.h,
                    ),
                    Center(
                        child: Text(
                      "Activity",
                      style: appbarTitle,
                    )),
                  ],
                ),
                bottom: TabBar(
                  labelStyle: tabBarTitleActivity,
                  tabs: [
                    Tab(text: "Penjualan"),
                    Tab(text: "Pesanan"),
                  ],
                ),
              ),
            ),
            backgroundColor: HexColor("#F7F7FA"),
            body: TabBarView(
              children: [
                //tab penjualan
                Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: ButtonTheme(
                            minWidth: 360.w,
                            height: 84.h,
                            child: RaisedButton(
                              color: HexColor("#D44000"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodForm()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r)),
                              child: Text(
                                "Jual Makanan",
                                style: GoogleFonts.poppins(
                                  fontSize: 24.51.sp,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#FFEFCF"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: ButtonTheme(
                            minWidth: 360.w,
                            height: 84.h,
                            child: RaisedButton(
                              color: HexColor("#464660"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopForm()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r)),
                              child: Text(
                                "Jual Barang",
                                style: GoogleFonts.poppins(
                                  fontSize: 24.51.sp,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#F1E9E5"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: ButtonTheme(
                            minWidth: 360.w,
                            height: 84.h,
                            child: RaisedButton(
                              color: HexColor("#0C4271"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServicesForm()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r)),
                              child: Text(
                                "Jual Jasa",
                                style: GoogleFonts.poppins(
                                  fontSize: 24.51.sp,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#F9DFDC"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ],
                ),
                //tab pesanan
                ListView(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is AuthSuccess) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: historyFood
                                .where('sellerID', isEqualTo: state.user.id)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: (snapshot.data!)
                                      .docs
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.w,
                                              right: 25.w,
                                              top: 10.h),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    DraggableScrollableSheet(
                                                        initialChildSize: 0.3,
                                                        builder:
                                                            (_, controller) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        "#F6F6F6"),
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(10.r)),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            9.h,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              62.w,
                                                                          height:
                                                                              8.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(17.r),
                                                                            color:
                                                                                HexColor("#C4C4C4").withOpacity(0.70),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#519259"),
                                                                            onPressed:
                                                                                () async {
                                                                              // await TransactionServicesFood
                                                                              //     .returnTransaction(
                                                                              //         e['userDocID'],
                                                                              //         e['sellerID'],
                                                                              //         e['price']);
                                                                              await TransactionServicesFood.returnTransaction(e['userDocID'], e['foodID'], e['sellerID'], e['price']);
                                                                              hfood.doc(e.id).update({
                                                                                'status': true,
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Terima Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            32.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#C84B31"),
                                                                            onPressed:
                                                                                () {
                                                                              hfood.doc(e.id).delete();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Tolak Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(10.r),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                //image item
                                                Container(
                                                  width: 108.w,
                                                  height: 108.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(5.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: HexColor(
                                                                "#864000")
                                                            .withOpacity(0.25),
                                                        blurRadius: 15,
                                                        offset: Offset(0, 5),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          e['image']),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e['name'],
                                                      style: categoryTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "Rp. ${e['price'].toString()}",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      "Detail Pesanan :",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      e['userName'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "${e['method_payment']} - ${e['method_order']}",
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      e['location'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                        return CircularProgressIndicator();
                      }
                    }),
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is AuthSuccess) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: historyShop
                                .where('sellerID', isEqualTo: state.user.id)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: (snapshot.data!)
                                      .docs
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.w,
                                              right: 25.w,
                                              top: 10.h),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    DraggableScrollableSheet(
                                                        initialChildSize: 0.3,
                                                        builder:
                                                            (_, controller) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        "#F6F6F6"),
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(10.r)),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            9.h,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              62.w,
                                                                          height:
                                                                              8.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(17.r),
                                                                            color:
                                                                                HexColor("#C4C4C4").withOpacity(0.70),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#519259"),
                                                                            onPressed:
                                                                                () async {
                                                                              // await TransactionServicesFood
                                                                              //     .returnTransaction(
                                                                              //         e['userDocID'],
                                                                              //         e['sellerID'],
                                                                              //         e['price']);
                                                                              await TransactionServicesShop.returnTransaction(e['userDocID'], e['shopID'], e['sellerID'], e['price']);
                                                                              hShop.doc(e.id).update({
                                                                                'status': true,
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Terima Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            32.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#C84B31"),
                                                                            onPressed:
                                                                                () {
                                                                              hShop.doc(e.id).delete();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Tolak Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(10.r),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                //image item
                                                Container(
                                                  width: 108.w,
                                                  height: 108.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(5.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: HexColor(
                                                                "#864000")
                                                            .withOpacity(0.25),
                                                        blurRadius: 15,
                                                        offset: Offset(0, 5),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          e['image']),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e['name'],
                                                      style: categoryTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "Rp. ${e['price'].toString()}",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      "Detail Pesanan :",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      e['userName'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "${e['method_payment']} - ${e['method_order']}",
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      e['location'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                        return CircularProgressIndicator();
                      }
                    }),
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is AuthSuccess) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: historyServices
                                .where('sellerID', isEqualTo: state.user.id)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: (snapshot.data!)
                                      .docs
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.w,
                                              right: 25.w,
                                              top: 10.h),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    DraggableScrollableSheet(
                                                        initialChildSize: 0.3,
                                                        builder:
                                                            (_, controller) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        "#F6F6F6"),
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(10.r)),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            9.h,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              62.w,
                                                                          height:
                                                                              8.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(17.r),
                                                                            color:
                                                                                HexColor("#C4C4C4").withOpacity(0.70),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#519259"),
                                                                            onPressed:
                                                                                () async {
                                                                              await TransactionServicesServices.returnTransaction(e['userDocID'], e['servicesID'], e['sellerID'], e['price']);
                                                                              sShop.doc(e.id).update({
                                                                                'status': true,
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Terima Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            32.h,
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                25.w,
                                                                            right: 25.w),
                                                                        child:
                                                                            ButtonTheme(
                                                                          minWidth:
                                                                              361.w,
                                                                          height:
                                                                              55.h,
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                HexColor("#C84B31"),
                                                                            onPressed:
                                                                                () {
                                                                              sShop.doc(e.id).delete();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                            child:
                                                                                Text(
                                                                              "Tolak Pesanan",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                letterSpacing: 2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(10.r),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                //image item
                                                Container(
                                                  width: 108.w,
                                                  height: 108.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(5.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: HexColor(
                                                                "#864000")
                                                            .withOpacity(0.25),
                                                        blurRadius: 15,
                                                        offset: Offset(0, 5),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          e['image']),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e['name'],
                                                      style: categoryTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "Rp. ${e['price'].toString()}",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      "Detail Pesanan :",
                                                      style: itemTitle,
                                                    ),
                                                    Text(
                                                      e['userName'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "${e['method_payment']}",
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      e['location'],
                                                      style: itemSubTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                        return CircularProgressIndicator();
                      }
                    }),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
