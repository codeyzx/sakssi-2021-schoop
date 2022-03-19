import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:schoop/models/transaction_model_seragam.dart';
import 'package:schoop/services/transaction_service_seragam.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/payment/payment_seragam_success.dart';

class SeragamConfirmPage extends StatefulWidget {
  final String seragam;
  final String payment;
  final String id;
  final TransactionModelSeragam transaction;
  const SeragamConfirmPage({
    Key? key,
    required this.seragam,
    required this.payment,
    required this.id,
    required this.transaction,
  }) : super(key: key);

  @override
  _SeragamConfirmPageState createState() => _SeragamConfirmPageState(
        this.seragam,
        this.payment,
        this.id,
        this.transaction,
      );
}

class _SeragamConfirmPageState extends State<SeragamConfirmPage> {
  final String _seragam;
  final String _payment;
  final String _id;
  final TransactionModelSeragam _transaction;
  _SeragamConfirmPageState(
    this._seragam,
    this._payment,
    this._id,
    this._transaction,
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
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  title: Text(
                    "Detail Pembayaran",
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
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Cicilan Pembayaran Seragam",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          'Rp. $_seragam',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Metode Pembayaran",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          _payment,
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Tanggal Transaksi",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          DateFormat.yMMMMd('en_US').format(DateTime.now()),
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#303030"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 1.sw,
                          height: 1.h,
                          color: Colors.black.withOpacity(0.15),
                        ),
                        SizedBox(
                          height: 245.h,
                        ),
                        ButtonTheme(
                          minWidth: 361.w,
                          height: 39.h,
                          child: RaisedButton(
                            color: HexColor("#0A81AB"),
                            onPressed: () async {
                              await TransactionServicesSeragam.saveTransaction(
                                  _transaction, _transaction.seragam, _id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeragamSuccessPage(
                                          _transaction.method)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Text(
                              "Konfirmasi",
                              style: buttonDetail,
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
}
