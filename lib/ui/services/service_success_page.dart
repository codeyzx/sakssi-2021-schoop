import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/shared/theme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class ServiceSuccessPage extends StatefulWidget {
  final String sellerName;
  final String sellerNumber;
  final String paymentMethod;
  final String location;
  const ServiceSuccessPage(
      this.sellerName, this.sellerNumber, this.paymentMethod, this.location,
      {Key? key})
      : super(key: key);

  @override
  _ServiceSuccessPageState createState() => _ServiceSuccessPageState(
      sellerName, sellerNumber, paymentMethod, location);
}

class _ServiceSuccessPageState extends State<ServiceSuccessPage> {
  final String _sellerName;
  final String _sellerNumber;
  final String _paymentMethod;
  final String _location;

  _ServiceSuccessPageState(this._sellerName, this._sellerNumber,
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
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Lottie.asset(
                    "assets/87686-check.json",
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
                  "Berhasil Memesan Jasa",
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
                      Text.rich(
                        TextSpan(
                          text: "Order Anda ",
                          style: textSuccess,
                          children: <InlineSpan>[
                            TextSpan(
                              text: "Sedang diproses",
                              style: orderNumberSuccess,
                            ),
                            TextSpan(
                              text: "  secepatnya, harap tunggu.",
                              style: textSuccess,
                            )
                          ],
                        ),
                      ),
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
                          color: HexColor("#0C4271"),
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
