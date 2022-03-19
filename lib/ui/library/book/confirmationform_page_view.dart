import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/services/scanner.dart';
import 'package:schoop/shared/theme.dart';
import 'package:intl/intl.dart';

class ConfirmationFormPage extends StatefulWidget {
  final TransactionModel transaction;
  final String peminjam;
  final int stok;

  const ConfirmationFormPage({
    Key? key,
    required this.transaction,
    required this.peminjam,
    required this.stok,
  }) : super(key: key);

  @override
  _ConfirmationFormPageState createState() => _ConfirmationFormPageState(
        this.transaction,
        this.peminjam,
        this.stok,
      );
}

class _ConfirmationFormPageState extends State<ConfirmationFormPage> {
  final TransactionModel _transaction;
  final String _peminjam;
  final int _stok;

  bool _loading = false;

  _ConfirmationFormPageState(
    this._transaction,
    this._peminjam,
    this._stok,
  );

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMMd('en_US').format(_transaction.endTime);
    CollectionReference perpustakaan =
        FirebaseFirestore.instance.collection('perpustakaan');
    final loadIndicator = Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );

    return ScreenUtilInit(
      designSize: Size(411, 731),
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
              "Konfirmasi Peminjaman",
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 52.h),
              Center(
                child: Container(
                  height: 130.h,
                  width: 320.w,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.w,
                            child: Text(
                              _transaction.judul,
                              style: judulBukuConfirm,
                            ),
                          ),
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                _transaction.penulis,
                                style: subBukuConfirm,
                              )),
                          Row(
                            children: [
                              FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Stok : ",
                                    style: subBukuConfirm,
                                  )),
                              FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '$_stok',
                                    style: subBukuConfirm,
                                  )),
                            ],
                          ),
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Lama Pinjam 7 hari",
                                style: subBukuConfirm,
                              )),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Container(
                        width: 91.w,
                        height: 129.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_transaction.image),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Center(
                child: Container(
                  width: 353.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.50),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.50),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        "https://img.icons8.com/color-glass/48/000000/check.png",
                        width: 30.w,
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Metode : ",
                        style: methodConfirm,
                      ),
                      Text(
                        this._transaction.method ==
                                TransactionMethod.bawa_pulang
                            ? "Bawa Pulang"
                            : "Baca di Perpustakaan",
                        style: methodConfirm,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal Pengembalian",
                      style: methodConfirm,
                    ),
                    Text(
                      formattedDate,
                      style: methodConfirm,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Peminjam",
                      style: methodConfirm,
                    ),
                    Text(
                      _peminjam,
                      style: methodConfirm,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 24.w),
                      width: 353.w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.50)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 110.h,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: perpustakaan.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: (snapshot.data!)
                            .docs
                            .map(
                              (e) => Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _loading = true;
                                    });
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Scanner(
                                          transaction: _transaction,
                                          stok: _stok,
                                          kursi: e['kursi_tersedia']);
                                    }));
                                  },
                                  child: _loading
                                      ? loadIndicator
                                      : Container(
                                          width: 325.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            color: HexColor("#39A2DB"),
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Konfirmasi",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      print('SNAPSHOT TAK ADA');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
