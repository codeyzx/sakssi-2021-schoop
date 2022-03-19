// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/ui/library/book/confirmationform_page_view.dart';

class ReadLibraryPage extends StatelessWidget {
  final TransactionModel transaction;
  final String peminjam;
  final int stok;

  const ReadLibraryPage({
    Key? key,
    required this.transaction,
    required this.peminjam,
    required this.stok,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference perpustakaan =
        FirebaseFirestore.instance.collection('perpustakaan');
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: HexColor("#39A2DB"),
                )),
            title: Text(
              "Baca di Perpustakaan",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Builder(
            builder: (context) => Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 1.sw,
                    height: 597.h,
                    decoration: BoxDecoration(
                      color: HexColor("#3A6073"),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: perpustakaan.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: (snapshot.data!)
                                    .docs
                                    .map((e) => Column(
                                          children: [
                                            SizedBox(height: 45.h),
                                            Center(
                                              child: Container(
                                                width: 249.04.w,
                                                height: 440.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/sketch.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 30.h),
                                            Container(
                                              width: 330.w,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Kursi Tersedia : ",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${e['kursi_tersedia']}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Jumlah Kursi  : ",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${e['total_kursi']}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            InkWell(
                                              onTap: () {
                                                if (e['kursi_tersedia'] == 0) {
                                                  print('kursi tersedia 0');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          snackBarUnSuccesful());
                                                } else {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ConfirmationFormPage(
                                                      transaction: transaction,
                                                      peminjam: peminjam,
                                                      stok: stok,
                                                    );
                                                  }));
                                                }
                                              },
                                              child: Container(
                                                width: 332.w,
                                                height: 40.h,
                                                margin: EdgeInsets.only(
                                                    left: 40.w, right: 40.w),
                                                decoration: BoxDecoration(
                                                  color: HexColor("#39A2DB"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Baca di Perpustakaan",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
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
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

snackBarUnSuccesful() {
  return SnackBar(
    content: Text(
      'Stok kursi tidak tersedia',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(),
  );
}
