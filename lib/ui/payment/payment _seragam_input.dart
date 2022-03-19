import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/transaction_model_seragam.dart';
import 'package:schoop/services/transaction_service_seragam.dart';
import 'package:schoop/ui/payment/payment_seragam_confirm.dart';

class SeragamInputPage extends StatefulWidget {
  final String id;
  final String nis;
  const SeragamInputPage({
    Key? key,
    required this.id,
    required this.nis,
  }) : super(key: key);

  @override
  _SeragamInputPageState createState() => _SeragamInputPageState(
        this.id,
        this.nis,
      );
}

class _SeragamInputPageState extends State<SeragamInputPage> {
  final String _id;
  final String _nis;

  TextEditingController _seragam = new TextEditingController();
  int _paymentRg = -1;
  String? _selectedValuePayment;
  final List<RadioGroup> _paymentMethod = [
    RadioGroup(index: 1, text: "Cash"),
    RadioGroup(index: 2, text: "Gopay"),
    RadioGroup(index: 3, text: "Ovo"),
    RadioGroup(index: 4, text: "Dana"),
  ];

  _SeragamInputPageState(
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
                  backgroundColor: HexColor("#0A81AB"),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:
                        Icon(Icons.arrow_back_ios, color: HexColor("#064635")),
                  ),
                  title: Text(
                    "Seragam",
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
                            "Bayar seragam",
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Paket Seragam",
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
                          controller: _seragam,
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
                            color: HexColor("#0A81AB"),
                            onPressed: () async {
                              TransactionModelSeragam transaction =
                                  TransactionModelSeragam(
                                      userID: _nis,
                                      method: _selectedValuePayment.toString(),
                                      startTime: DateTime.now(),
                                      seragam: int.parse(_seragam.text));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeragamConfirmPage(
                                          seragam:
                                              transaction.seragam.toString(),
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
