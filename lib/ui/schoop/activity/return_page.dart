import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/services/scanner_return.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReturnPage extends StatefulWidget {
  final String idTransaction;
  final TransactionModel transaction;

  ReturnPage({
    required this.idTransaction,
    required this.transaction,
    Key? key,
  }) : super(key: key);

  @override
  _ReturnPageState createState() => _ReturnPageState(
        idTransaction,
        transaction,
        duration: transaction.endTime.difference(DateTime.now()).isNegative
            ? Duration(milliseconds: 1)
            : transaction.endTime.difference(DateTime.now()),
        date: transaction.endTime,
      );
}

class _ReturnPageState extends State<ReturnPage> with TickerProviderStateMixin {
  final String _idTransaction;
  final TransactionModel _transaction;
  Duration duration;
  DateTime date;

  _ReturnPageState(
    this._idTransaction,
    this._transaction, {
    required this.duration,
    required this.date,
  });

  bool isLate = false;
  late AnimationController controller;
  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        if (controller.isAnimating) {
          setState(() {
            progress = controller.value;
            controller.reverse(
                from: controller.value == 0 ? 1.0 : controller.value);
          });
        } else {
          setState(() {
            progress = 1.0;
            isLate = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd('en_US').format(date);
    CollectionReference transactionCollection =
        FirebaseFirestore.instance.collection('history');
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);

      return (to.difference(from).inHours / 24).round();
    }

    final kembalikan = Container(
      margin: EdgeInsets.only(left: 34.w, right: 32.w),
      width: double.infinity,
      height: 45.h,
      child: RaisedButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ScannerReturn(
                idTransaction: _idTransaction,
                isLate: isLate,
                transaction: _transaction);
          }));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLate == true
                    ? [HexColor("#F2353B"), HexColor("#F3494E")]
                    : [HexColor("#39A2DB"), HexColor("#468df0")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              isLate == true ? "Bayar Denda" : "Kembalikan Buku",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontFamily: 'Poppins',
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );

    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
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
              "Waktu Tersisa",
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
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Lottie.asset("assets/timer.json",
                      width: 219.w, height: 235.h),
                  SizedBox(height: 30.h),
                  Center(
                    child: SlideCountdown(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                      duration: duration,
                      durationTitle: DurationTitle.id(),
                      separatorType: SeparatorType.symbol,
                      slideDirection: SlideDirection.down,
                      separator: ':',
                      padding: EdgeInsets.only(
                          top: 14.h, bottom: 20.h, left: 20.w, right: 20.w),
                      fade: true,
                      decoration: BoxDecoration(
                        color: isLate == true
                            ? HexColor("#F2353B")
                            : HexColor("#3A6073"),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      infinityCountUp: isLate,
                      onDone: () {
                        setState(() {
                          isLate = true;
                          final selisihHari =
                              daysBetween(_transaction.endTime, DateTime.now());
                          print(selisihHari);
                          print('KESATU - SELISIH HARI');
                          final totalDenda = selisihHari * 2000;
                          transactionCollection.doc(_idTransaction).update({
                            'denda': totalDenda,
                          });
                          print(totalDenda);
                          print('KEDUA - DENDA');
                          isLate = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Text(
                      isLate == true
                          ? "Denda yang harus dibayar: Rp.${_transaction.denda}"
                          : "Jangan Lupa Kembalikan Buku",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    child: Text(
                      "Tenggat Pengembalian : ",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          color: Colors.black.withOpacity(0.75)),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  kembalikan,
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
