// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/shared/theme.dart';

import 'package:schoop/ui/payment/payment%20_seragam_input.dart';
import 'package:schoop/ui/payment/payment_spp_input.dart';
import 'package:schoop/ui/schoop/search/search_page.dart';

class PaymentItems extends StatefulWidget {
  const PaymentItems({Key? key}) : super(key: key);

  @override
  _PaymentItemsState createState() => _PaymentItemsState();
}

class _PaymentItemsState extends State<PaymentItems> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: HexColor("#F7F7FA"),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: HexColor("#0A81AB"),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  "Payment",
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    color: HexColor("#F9DFDC"),
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
                      color: HexColor("#0A81AB"),
                      child: Padding(
                        padding: EdgeInsets.only(left: 70.w, top: 80.h),
                        child: Text(
                          "Bayar SPP atau lunasi seragam",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: HexColor("#F9DFDC"),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
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
                                    (e) => Column(
                                      children: [
                                        SizedBox(height: 15.h),
                                        Container(
                                          width: 371.w,
                                          height: 159.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15.r),
                                            color: HexColor("#0C4271"),
                                            boxShadow: [
                                              BoxShadow(
                                                color: HexColor("#3E2EF1")
                                                    .withOpacity(0.25),
                                                offset: Offset(0, 8),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 16.h,
                                                left: 11.w,
                                                right: 9.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Pembayaran Tersisa :",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18.sp,
                                                        color:
                                                            HexColor("#F9DFDC"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/double-circle.png",
                                                      width: 36.w,
                                                      height: 20.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 9.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 139.w,
                                                          height: 31.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: HexColor(
                                                                "#F9DFDC"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "SPP",
                                                              style:
                                                                  activityTitle,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        Text(
                                                            'Rp. ' +
                                                                (5000000 -
                                                                        e[
                                                                            'spp'])
                                                                    .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 22.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: HexColor(
                                                                  "#5FE675"),
                                                            )),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 139.w,
                                                          height: 31.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: HexColor(
                                                                "#F9DFDC"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Seragam",
                                                              style:
                                                                  activityTitle,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        Text(
                                                          'Rp. ' +
                                                              (2000000 -
                                                                      e['seragam'])
                                                                  .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 22.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: HexColor(
                                                                "#5FE675"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 46.h),
                                        Container(
                                          width: 1.sw,
                                          height: 1.h,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 21.w, right: 21.w),
                                          child: InkWell(
                                            onTap: () {
                                              (e['spp'] >= 5000000)
                                                  ? ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          snackBarUnSuccesful())
                                                  : Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SppInputPage(
                                                                id: state
                                                                    .user.id,
                                                                nis: state
                                                                    .user.nis,
                                                              )));
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  //container background warna image
                                                  width: 70.w,
                                                  height: 70.h,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#FFAB4C"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: HexColor(
                                                                "#004365")
                                                            .withOpacity(0.15),
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/coin.png",
                                                      width: 35.w,
                                                      height: 35.h,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Bayar SPP",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            HexColor("#303030"),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Anda bisa mencicil pembayaran SPP sekolah. \nPembayaran dapat dilakukan online/offline.",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12.sp,
                                                        color: HexColor(
                                                                "#303030")
                                                            .withOpacity(0.55),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      width: 270.w,
                                                      height: 1.h,
                                                      color: Colors.black
                                                          .withOpacity(0.15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 21.w, right: 21.w),
                                          child: InkWell(
                                            onTap: () {
                                              (e['seragam'] >= 2000000)
                                                  ? ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          snackBarUnSuccesful())
                                                  : showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          makeDismissible(
                                                        child:
                                                            DraggableScrollableSheet(
                                                                initialChildSize:
                                                                    0.8,
                                                                builder: (_,
                                                                        controller) =>
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: HexColor(
                                                                            "#F6F6F6"),
                                                                        borderRadius:
                                                                            BorderRadius.vertical(top: Radius.circular(10.r)),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                9.h,
                                                                          ),
                                                                          Center(
                                                                            child:
                                                                                Container(
                                                                              width: 62.w,
                                                                              height: 8.h,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(17.r),
                                                                                color: HexColor("#C4C4C4").withOpacity(0.70),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                34.h,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 23.w, right: 15.w),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                buildItemSeragamPop("Baju Putih", "Rp 250.000"),
                                                                                buildItemSeragamPop("Baju Batik", "Rp 250.000"),
                                                                                buildItemSeragamPop("Baju Praktek", "Rp 250.000"),
                                                                                buildItemSeragamPop("Baju Muslim", "Rp 250.000"),
                                                                                buildItemSeragamPop("Celana Abu", "Rp 250.000"),
                                                                                buildItemSeragamPop("Dasi", "Rp 250.000"),
                                                                                buildItemSeragamPop("Topi", "Rp 250.000"),
                                                                                buildItemSeragamPop("Bet", "Rp 250.000"),
                                                                                buildItemSeragamPop("Tag Nama", "Rp 250.000"),
                                                                                buildItemSeragamPop("Pin", "Rp 250.000"),
                                                                                SizedBox(
                                                                                  height: 22.h,
                                                                                ),
                                                                                Text(
                                                                                  "*Anda bisa mencicil pembayaran",
                                                                                  style: GoogleFonts.poppins(
                                                                                    fontSize: 12.sp,
                                                                                    color: HexColor("#303030").withOpacity(0.55),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 8.h),
                                                                                ButtonTheme(
                                                                                  minWidth: 361.w,
                                                                                  height: 39.h,
                                                                                  child: RaisedButton(
                                                                                    color: HexColor("#0A81AB"),
                                                                                    onPressed: () {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SeragamInputPage(id: state.user.id, nis: state.user.nis)));
                                                                                    },
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                                                                                    child: Text(
                                                                                      "Bayar",
                                                                                      style: buttonDetail,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                      ),
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              10.r),
                                                        ),
                                                      ),
                                                    );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  //container background warna image
                                                  width: 70.w,
                                                  height: 70.h,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#654CFF"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: HexColor(
                                                                "#654CFF")
                                                            .withOpacity(0.15),
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/shirt.png",
                                                      width: 35.w,
                                                      height: 35.h,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Bayar Seragam",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            HexColor("#303030"),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Pembayaran seragam secara sepaket\n(semua seragam sudah termasuk).",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12.sp,
                                                        color: HexColor(
                                                                "#303030")
                                                            .withOpacity(0.55),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      width: 270.w,
                                                      height: 1.h,
                                                      color: Colors.black
                                                          .withOpacity(0.15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  snackBarUnSuccesful() {
    return SnackBar(
      content: Text(
        'Stok tidak tersedia',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(),
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

  Padding buildItemSeragamPop(String item, String harga) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 26.w,
            height: 26.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.r),
              color: HexColor("#C4C4C4"),
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 331.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: itemNamePayment,
                    ),
                    Text(
                      harga,
                      style: itemNamePayment,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: 330.w,
                height: 1.h,
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
