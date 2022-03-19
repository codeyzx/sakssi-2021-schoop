// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class FoodSuccessPage extends StatefulWidget {
//   no_hp
// seller_name
// order_method
// payment_method
  final String sellerName;
  final String sellerNumber;
  final String orderMethod;
  final String paymentMethod;
  final String location;
  const FoodSuccessPage(this.sellerName, this.sellerNumber, this.orderMethod,
      this.paymentMethod, this.location,
      {Key? key})
      : super(key: key);

  @override
  _FoodSuccessPageState createState() => _FoodSuccessPageState(
      sellerName, sellerNumber, orderMethod, paymentMethod, location);
}

class _FoodSuccessPageState extends State<FoodSuccessPage> {
  final String _sellerName;
  final String _sellerNumber;
  final String _orderMethod;
  final String _paymentMethod;
  final String _location;

  _FoodSuccessPageState(this._sellerName, this._sellerNumber, this._orderMethod,
      this._paymentMethod, this._location);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor("#F7F7FA"),
            body: Column(
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/food-animation.json",
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                    repeat: false,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Center(
                    child: Text(
                  "Berhasil Memesan Makanan",
                  style: titleSuccess,
                )),
                SizedBox(height: 60.h),
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 25.w),
                  child: Column(
                    children: [
                      (_paymentMethod == 'Cash'
                          ? Text(
                              "Silakan Hubungi Penjual jika perlu : ",
                              style: textSuccess,
                            )
                          : Text(
                              "Silakan Lanjutkan untuk melakukan pembayaran ke :",
                              style: textSuccess,
                            )),
                      SizedBox(height: 11.h),
                      Center(
                        child: (_paymentMethod == 'Cash'
                            ? Container(
                                width: 360.w,
                                height: 76.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 27.w, right: 23.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //logo payment
                                      Image.asset(
                                        "assets/whatsapp.png",
                                        width: 100.w,
                                        height: 60.h,
                                        fit: BoxFit.cover,
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 6.h),
                                          //no telp seller
                                          Text(
                                            _sellerNumber,
                                            style: textTransaction,
                                          ),
                                          SizedBox(height: 6.h),
                                          Container(
                                            width: 146.w,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  //seller name
                                                  child: Text(
                                                    _sellerName,
                                                    style: sellerSuccess,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: 360.w,
                                height: 76.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 27.w, right: 23.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //logo payment
                                      Image.asset(
                                        "assets/$_paymentMethod.png",
                                        width: 123.w,
                                        height: 35.h,
                                        fit: BoxFit.cover,
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 6.h),
                                          //no telp seller
                                          Text(
                                            _sellerNumber,
                                            style: textTransaction,
                                          ),
                                          SizedBox(height: 6.h),
                                          Container(
                                            width: 146.w,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  //seller name
                                                  child: Text(
                                                    _sellerName,
                                                    style: sellerSuccess,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                      ),
                      SizedBox(height: 18.h),
                      (_orderMethod == 'Ambil di tempat'
                          ? Text.rich(
                              TextSpan(
                                text: "Ambil pesanan anda ke ",
                                style: textSuccess,
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: _location,
                                    style: orderNumberSuccess,
                                  ),
                                  TextSpan(
                                    text:
                                        " Secepatnya dan hubungi penjual jika penting",
                                    style: textSuccess,
                                  )
                                ],
                              ),
                            )
                          : Text.rich(
                              TextSpan(
                                text: "Order Anda ",
                                style: textSuccess,
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "Sedang diproses secepatnya, ",
                                    style: orderNumberSuccess,
                                  ),
                                  TextSpan(
                                    text: " harap tunggu.",
                                    style: textSuccess,
                                  )
                                ],
                              ),
                            )),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        width: 361.w,
                        height: 1.h,
                        color: HexColor("#303030"),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                          child: Text(
                        "Terima kasih sudah belanja di Schoop",
                        style: titleSuccess,
                        textAlign: TextAlign.center,
                      )),
                      SizedBox(
                        height: 25.h,
                      ),
                      ButtonTheme(
                        minWidth: 361.w,
                        height: 39.h,
                        child: RaisedButton(
                          color: HexColor("#D44000"),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavBar()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Text(
                            "Kembali ke Beranda",
                            style: buttonDetail,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
