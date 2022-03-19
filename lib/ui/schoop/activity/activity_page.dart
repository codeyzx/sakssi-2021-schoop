// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/ui/schoop/activity/return_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('history_food');
    final Query food = foodCollection.where('status', isEqualTo: true);
    CollectionReference shopCollection =
        FirebaseFirestore.instance.collection('history_shop');
    final Query shop = shopCollection.where('status', isEqualTo: true);
    CollectionReference servicesCollection =
        FirebaseFirestore.instance.collection('history_services');
    final Query services = servicesCollection.where('status', isEqualTo: true);
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
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
                    Tab(text: "Riwayat Pembelian"),
                    Tab(text: "Riwayat Buku"),
                  ],
                ),
              ),
            ),
            backgroundColor: HexColor("#F7F7FA"),
            body: TabBarView(
              children: [
                ListView(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is AuthSuccess) {
                        return Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 26.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card Pengeluaran
                              StreamBuilder<QuerySnapshot>(
                                  stream: users
                                      .where('nis', isEqualTo: state.user.nis)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map((e) => Column(
                                                  children: [
                                                    SizedBox(height: 18.h),
                                                    Container(
                                                      width: 360.w,
                                                      height: 159.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#F2C94C"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.25),
                                                            offset:
                                                                Offset(0, 1),
                                                            blurRadius: 5,
                                                            spreadRadius: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 13.w,
                                                                right: 22.w,
                                                                top: 11.h,
                                                                bottom: 10.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Total Pengeluaran",
                                                                  style:
                                                                      activityTitle,
                                                                ),
                                                                Image.asset(
                                                                  "assets/double-circle.png",
                                                                  width: 36.w,
                                                                  height: 20.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 14.h,
                                                            ),
                                                            //isi pengeluaran
                                                            Center(
                                                                child: Text(
                                                              "Rp. " +
                                                                  e['pengeluaran']
                                                                      .toString(),
                                                              style:
                                                                  moneyActivity,
                                                            )),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            //isi nis user
                                                            Text(
                                                              "*Saving Account on 2021118501",
                                                              style:
                                                                  lightActivity,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 30.h),
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
                                                                    "#5FE675"),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Pendapatan",
                                                                  style:
                                                                      activityTitle,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 4.h),
                                                            Text(
                                                              "Rp. " +
                                                                  e['pendapatan']
                                                                      .toString(),
                                                              style:
                                                                  subMoneyActivity,
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width: 3.w,
                                                          height: 49.h,
                                                          color: HexColor(
                                                              "#303030"),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              width: 139.w,
                                                              height: 31.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    "#ED2E5D"),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Pengeluaran",
                                                                  style:
                                                                      activityTitle,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 4.h),
                                                            Text(
                                                              "Rp. " +
                                                                  e['pengeluaran']
                                                                      .toString(),
                                                              style:
                                                                  subMoneyActivity,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 30.h),
                                                    Text(
                                                      "Riwayat Pembelian",
                                                      style: activityTitle,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Container(
                                                      width: 175.w,
                                                      height: 1.h,
                                                      color:
                                                          HexColor("#303030"),
                                                    ),
                                                    SizedBox(height: 15.h),
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

                              //List riwayat pembelian dibawah ini
                              // * FOOD
                              StreamBuilder<QuerySnapshot>(
                                  stream: food
                                      .where('userID',
                                          isEqualTo: state.user.nis)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map(
                                              (e) => Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15.h),
                                                      width: 361.w,
                                                      height: 58.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#C4C4C4"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: HexColor(
                                                                    "#2E4C67")
                                                                .withOpacity(
                                                                    0.25),
                                                            offset:
                                                                Offset(0, 5),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 168.w,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: FittedBox(
                                                                      fit: BoxFit.scaleDown,
                                                                      //item name
                                                                      child: Text(
                                                                        e['name'],
                                                                        style:
                                                                            itemTitleActivity,
                                                                      )),
                                                                ),
                                                              ),
                                                              //date
                                                              Text(
                                                                DateFormat.yMMMMd(
                                                                        'en_US')
                                                                    .format(e[
                                                                            'startTime']
                                                                        .toDate()),
                                                                style:
                                                                    itemDateActivity,
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            width: 133.w,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  //price name
                                                                  child: Text(
                                                                    'Rp. ' +
                                                                        e['price']
                                                                            .toString(),
                                                                    style:
                                                                        subMoneyActivity,
                                                                  )),
                                                            ),
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
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),

                              // * SHOP
                              StreamBuilder<QuerySnapshot>(
                                  stream: shop
                                      .where('userID',
                                          isEqualTo: state.user.nis)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map(
                                              (e) => Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15.h),
                                                      width: 361.w,
                                                      height: 58.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#C4C4C4"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: HexColor(
                                                                    "#2E4C67")
                                                                .withOpacity(
                                                                    0.25),
                                                            offset:
                                                                Offset(0, 5),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 168.w,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: FittedBox(
                                                                      fit: BoxFit.scaleDown,
                                                                      //item name
                                                                      child: Text(
                                                                        e['name'],
                                                                        style:
                                                                            itemTitleActivity,
                                                                      )),
                                                                ),
                                                              ),
                                                              //date
                                                              Text(
                                                                DateFormat.yMMMMd(
                                                                        'en_US')
                                                                    .format(e[
                                                                            'startTime']
                                                                        .toDate()),
                                                                style:
                                                                    itemDateActivity,
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            width: 133.w,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  //price name
                                                                  child: Text(
                                                                    'Rp. ' +
                                                                        e['price']
                                                                            .toString(),
                                                                    style:
                                                                        subMoneyActivity,
                                                                  )),
                                                            ),
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
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),

                              // * SERVICES
                              StreamBuilder<QuerySnapshot>(
                                  stream: services
                                      .where('userID',
                                          isEqualTo: state.user.nis)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map(
                                              (e) => Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 15.h),
                                                      width: 361.w,
                                                      height: 58.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#C4C4C4"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: HexColor(
                                                                    "#2E4C67")
                                                                .withOpacity(
                                                                    0.25),
                                                            offset:
                                                                Offset(0, 5),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 168.w,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: FittedBox(
                                                                      fit: BoxFit.scaleDown,
                                                                      //item name
                                                                      child: Text(
                                                                        e['name'],
                                                                        style:
                                                                            itemTitleActivity,
                                                                      )),
                                                                ),
                                                              ),
                                                              //date
                                                              Text(
                                                                DateFormat.yMMMMd(
                                                                        'en_US')
                                                                    .format(e[
                                                                            'startTime']
                                                                        .toDate()),
                                                                style:
                                                                    itemDateActivity,
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            width: 133.w,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  //price name
                                                                  child: Text(
                                                                    'Rp. ' +
                                                                        e['price']
                                                                            .toString(),
                                                                    style:
                                                                        subMoneyActivity,
                                                                  )),
                                                            ),
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
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    })
                  ],
                ),
                ListView(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthSuccess) {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;

                          final CollectionReference transactionCollection =
                              firestore.collection('history');
                          final Query transactions = transactionCollection
                              .where("userID", isEqualTo: state.user.nis);

                          return Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: transactions
                                      .where('status_buku', isEqualTo: false)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.docs);
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map(
                                              (e) => Container(
                                                margin: EdgeInsets.only(
                                                    left: 32.w,
                                                    right: 56.w,
                                                    top: 19.h),
                                                width: 323.w,
                                                height: 155.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    TransactionModel
                                                        transaction =
                                                        TransactionModel(
                                                      userID: e['userID'],
                                                      denda: e['denda'],
                                                      method: e['method'] ==
                                                              "Bawa Pulang"
                                                          ? TransactionMethod
                                                              .bawa_pulang
                                                          : TransactionMethod
                                                              .baca_di_perpustakaan,
                                                      startTime: DateTime
                                                          .fromMillisecondsSinceEpoch(e[
                                                                  'startTime']
                                                              .millisecondsSinceEpoch),
                                                      endTime: DateTime
                                                          .fromMillisecondsSinceEpoch(e[
                                                                  'endTime']
                                                              .millisecondsSinceEpoch),
                                                      bookID: e['bookID'],
                                                      judul: e['judul'],
                                                      jumlahHalaman:
                                                          e['jumlahHalaman'],
                                                      image: e['image'],
                                                      penulis: e['penulis'],
                                                    );
                                                    Navigator.push(
                                                      this.context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReturnPage(
                                                          idTransaction: e.id,
                                                          transaction:
                                                              transaction,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 104.w,
                                                        height: 153.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          image:
                                                              DecorationImage(
                                                            //book image
                                                            image: NetworkImage(
                                                                e['image']),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.35),
                                                              offset:
                                                                  Offset(0, 5),
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16.w,
                                                      ),
                                                      Container(
                                                        width: 200.w,
                                                        height: 146.h,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //book title
                                                            Text(
                                                              e['judul'],
                                                              style:
                                                                  activityTitle,
                                                            ),
                                                            SizedBox(
                                                              height: 9.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  e['penulis'],
                                                                  style:
                                                                      lightActivity,
                                                                ),
                                                                Text(
                                                                  "${e['jumlahHalaman'].toString()} Pages",
                                                                  style:
                                                                      lightActivity,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(e['status_buku'] ==
                                                                        true
                                                                    ? "Buku Sudah Dikembalikan"
                                                                    : "Buku Belum Dikembalikan"),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              StreamBuilder<QuerySnapshot>(
                                  stream: transactions
                                      .where('status_buku', isEqualTo: true)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.docs);
                                      return Column(
                                        children: (snapshot.data!)
                                            .docs
                                            .map(
                                              (e) => Container(
                                                margin: EdgeInsets.only(
                                                    left: 32.w,
                                                    right: 56.w,
                                                    top: 19.h),
                                                width: 323.w,
                                                height: 155.h,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 104.w,
                                                        height: 153.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          image:
                                                              DecorationImage(
                                                            //book image
                                                            image: NetworkImage(
                                                                e['image']),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.35),
                                                              offset:
                                                                  Offset(0, 5),
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16.w,
                                                      ),
                                                      Container(
                                                        width: 200.w,
                                                        height: 146.h,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //book title
                                                            Text(
                                                              e['judul'],
                                                              style:
                                                                  activityTitle,
                                                            ),
                                                            SizedBox(
                                                              height: 9.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  e['penulis'],
                                                                  style:
                                                                      lightActivity,
                                                                ),
                                                                Text(
                                                                  "${e['jumlahHalaman'].toString()} Pages",
                                                                  style:
                                                                      lightActivity,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(e['status_buku'] ==
                                                                        true
                                                                    ? "Buku Sudah Dikembalikan"
                                                                    : "Buku Belum Dikembalikan"),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
