import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/transaction_model_spp.dart';
import 'package:schoop/services/transaction_service_spp.dart';

import 'package:schoop/ui/payment/payment_spp_confirm.dart';

class SppInputPage extends StatefulWidget {
  final String id;
  final String nis;
  const SppInputPage({
    Key? key,
    required this.id,
    required this.nis,
  }) : super(key: key);

  @override
  _SppInputPageState createState() => _SppInputPageState(
        this.id,
        this.nis,
      );
}

class _SppInputPageState extends State<SppInputPage> {
  final String _id;
  final String _nis;

  TextEditingController _spp = new TextEditingController();
  int _paymentRg = -1;
  String? _selectedValuePayment;
  final List<RadioGroup> _paymentMethod = [
    RadioGroup(index: 1, text: "Cash"),
    RadioGroup(index: 2, text: "Gopay"),
    RadioGroup(index: 3, text: "Ovo"),
    RadioGroup(index: 4, text: "Dana"),
  ];

  _SppInputPageState(
    this._id,
    this._nis,
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: HexColor("#F7F7FA"),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: HexColor("#FFAB4C"),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:
                        Icon(Icons.arrow_back_ios, color: HexColor("#064635")),
                  ),
                  title: Text(
                    "SPP",
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      color: HexColor("#064635"),
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
                        color: HexColor("#FFAB4C"),
                        child: Padding(
                          padding: EdgeInsets.only(left: 70.w, top: 80.h),
                          child: Text(
                            "Bayar SPP",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: HexColor("#064635"),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "SPP Sekolah",
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Masukkan Nominal :",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _spp,
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                "Rp",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#303030").withOpacity(0.50),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 45.h),
                        Text(
                          "Metode Pembayaran",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#303030"),
                          ),
                        ),
                        //radio button dibawah ini sampai sebelum sizedbox
                        _buildRadioButton2(),
                        //ini sized box
                        SizedBox(
                          height: 125.h,
                        ),
                        ButtonTheme(
                          minWidth: 361.w,
                          height: 39.h,
                          child: RaisedButton(
                            color: HexColor("#FFAB4C"),
                            onPressed: () async {
                              TransactionModelSpp transaction =
                                  TransactionModelSpp(
                                      userID: _nis,
                                      method: _selectedValuePayment.toString(),
                                      startTime: DateTime.now(),
                                      spp: int.parse(_spp.text));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SppConfirmPage(
                                          spp: transaction.spp.toString(),
                                          payment: transaction.method,
                                          id: _id,
                                          transaction: transaction)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Text(
                              "Konfirmasi",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#064635"),
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _paymentMethod
          .map((programming) => Row(
                children: <Widget>[
                  Radio(
                    value: programming.index,
                    groupValue: _paymentRg,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      setState(() {
                        _paymentRg = value as int;
                        _selectedValuePayment = programming.text;
                      });
                    },
                  ),
                  Text(
                    programming.text,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: HexColor("#303030"),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

class RadioGroup {
  final int index;
  final String text;
  RadioGroup({required this.index, required this.text});
}
