import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/services/pdf_api.dart';
import 'package:schoop/services/pdf_viewer_page.dart';
import 'package:schoop/ui/library/book/confirmationform_page_view.dart';
import 'package:schoop/ui/library/book/libraryread_page_view.dart';

class BookPage extends StatefulWidget {
  final String id;
  final String image;
  final String judul;
  final int jumlahHalaman;
  final int stok;
  final String penulis;
  final String sinopsis;
  final bool isKonvensional;
  final String ebook;

  BookPage(
    this.id,
    this.image,
    this.judul,
    this.jumlahHalaman,
    this.stok,
    this.isKonvensional,
    this.penulis,
    this.sinopsis,
    this.ebook, {
    Key? key,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(id, image, judul,
      jumlahHalaman, stok, penulis, sinopsis, isKonvensional, ebook);
}

class _DetailScreenState extends State<BookPage> {
  String _id;
  String _image;
  String _judul;
  int _jumlahHalaman;
  int _stok;
  String _penulis;
  String _sinopsis;
  bool _isKonvensional;
  String _ebook;

  _DetailScreenState(
    this._id,
    this._image,
    this._judul,
    this._jumlahHalaman,
    this._stok,
    this._penulis,
    this._sinopsis,
    this._isKonvensional,
    this._ebook,
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(
            builder: (context) => Column(
              children: (this._isKonvensional == true)
                  ? [
                      Stack(
                        children: [
                          Container(
                            width: 1.sw,
                            height: 1.sh,
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Image.network(_image)),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 383.h),
                                        width: 168.w,
                                        height: 246.h,
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                          child: Image.network(
                                            _image,
                                            width: 168.w,
                                            height: 246.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 1.sw,
                                    height: 0.551.sh,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30.r),
                                        topLeft: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45.w),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 22),
                                            child: Text(
                                              _judul,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          //Box untuk info buku
                                          Container(
                                            width: 321.w,
                                            height: 47.h,
                                            decoration: BoxDecoration(
                                              color: HexColor("#39A2DB")
                                                  .withOpacity(0.55),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // Penulis

                                                Container(
                                                  width: 86.w,
                                                  height: 35.h,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Penulis",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: HexColor(
                                                              "#858588"),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          _penulis,
                                                          softWrap: false,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: HexColor(
                                                                "#55585F"),
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //Jumlah Halaman

                                                Container(
                                                  width: 86.w,
                                                  height: 35.h,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Halaman",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: HexColor(
                                                              "#858588"),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$_jumlahHalaman',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: HexColor(
                                                              "#55585F"),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //Stok

                                                Container(
                                                  width: 86.w,
                                                  height: 35.h,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Stok',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: HexColor(
                                                              "#858588"),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$_stok',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: HexColor(
                                                              "#55585F"),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Teks Deskripsi----------

                                              Text(
                                                "Deskripsi",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),

                                          //Sinopsis ----------
                                          Container(
                                            width: 318.w,
                                            height: 128.h,
                                            child: ListView(
                                              children: [
                                                Text(
                                                  _sinopsis,
                                                  style: GoogleFonts.poppins(
                                                    color: HexColor('#787878'),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),

                                          //Button Tambah ke keranjang ----------

                                          Center(
                                            child: TextButton(
                                              onPressed: () {
                                                if (_stok == 0) {
                                                  print('stok 0');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          snackBarUnSuccesful());
                                                } else {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        buildSheet(),
                                                    backgroundColor:
                                                        HexColor("#ECF2FE"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            30.r),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: 325.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#39A2DB'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Baca Buku",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          HexColor('#FFFFFF'),
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]
                  : [
                      Stack(
                        children: [
                          Container(
                            width: 1.sw,
                            height: 1.sh,
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Image.network(_image)),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 383.h),
                                        width: 168.w,
                                        height: 246.h,
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                          child: Image.network(
                                            _image,
                                            width: 168.w,
                                            height: 246.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 1.sw,
                                    height: 0.551.sh,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30.r),
                                        topLeft: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45.w),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 22),
                                            child: Text(
                                              _judul,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          //Box untuk info buku
                                          Container(
                                            width: 321.w,
                                            height: 47.h,
                                            decoration: BoxDecoration(
                                              color: HexColor("#39A2DB")
                                                  .withOpacity(0.55),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // Penulis
                                                Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 119.w,
                                                    height: 35.h,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Penulis",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: HexColor(
                                                                "#858588"),
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(
                                                            _penulis,
                                                            softWrap: false,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: HexColor(
                                                                  "#55585F"),
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //Jumlah Halaman

                                                Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 86.w,
                                                    height: 35.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Halaman",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: HexColor(
                                                                "#858588"),
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          '$_jumlahHalaman',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: HexColor(
                                                                "#55585F"),
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Teks Deskripsi----------

                                              Text(
                                                "Deskripsi",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),

                                          //Sinopsis ----------
                                          Container(
                                            width: 318.w,
                                            height: 128.h,
                                            child: ListView(
                                              children: [
                                                Text(
                                                  _sinopsis,
                                                  style: GoogleFonts.poppins(
                                                    color: HexColor('#787878'),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),

                                          //Button Tambah ke keranjang ----------

                                          Center(
                                            child: TextButton(
                                              onPressed: () async {
                                                final url = _ebook;
                                                final file =
                                                    //     await PDFApi.loadNetwork(url);
                                                    await PDFApi.loadNetwork(
                                                        url);
                                                if (file == null) {
                                                  return;
                                                }
                                                openPDF(context, file);
                                              },
                                              child: Container(
                                                width: 325.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#39A2DB'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Baca Buku",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          HexColor('#FFFFFF'),
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: 37.0.h,
            width: 37.w,
            child: FittedBox(
              child: FloatingActionButton(
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent.withOpacity(0),
                onPressed: () => Navigator.pop(context),
                elevation: 10,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        ),
      ),
    );
  }

  Widget buildSheet() => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 41.h),
                Center(
                  child: InkWell(
                    onTap: () {
                      TransactionModel transaction = TransactionModel(
                          userID: state.user.nis,
                          denda: state.user.denda,
                          method: TransactionMethod.bawa_pulang,
                          startTime: DateTime.now(),
                          endTime: DateTime.now().add(Duration(days: 7)),
                          bookID: _id,
                          judul: _judul,
                          jumlahHalaman: _jumlahHalaman,
                          image: _image,
                          penulis: _penulis);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ConfirmationFormPage(
                          transaction: transaction,
                          peminjam: state.user.name,
                          stok: _stok,
                        );
                      }));
                    },
                    child: Container(
                      width: 332.w,
                      height: 49.h,
                      decoration: BoxDecoration(
                        color: HexColor("#3A6073"),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Center(
                        child: Text(
                          "Bawa Pulang",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      TransactionModel transaction = TransactionModel(
                        userID: state.user.nis,
                        denda: state.user.denda,
                        method: TransactionMethod.baca_di_perpustakaan,
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(Duration(days: 7)),
                        bookID: _id,
                        judul: _judul,
                        jumlahHalaman: _jumlahHalaman,
                        image: _image,
                        penulis: _penulis,
                      );

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReadLibraryPage(
                          transaction: transaction,
                          peminjam: state.user.name,
                          stok: _stok,
                        );
                      }));
                    },
                    child: Container(
                      width: 332.w,
                      height: 49.h,
                      decoration: BoxDecoration(
                        color: HexColor("#39A2DB"),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Center(
                        child: Text(
                          "Baca di Perpustakaan",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 41.h,
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      );
}

void openPDF(BuildContext context, File file) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
    );

snackBarUnSuccesful() {
  return SnackBar(
    content: Text(
      'Stok buku tidak tersedia',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(),
  );
}
