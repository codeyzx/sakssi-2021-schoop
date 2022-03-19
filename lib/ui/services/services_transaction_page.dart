// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_this, prefer_const_literals_to_create_immutables, deprecated_member_use

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:schoop/models/transaction_model_services.dart';
// import 'package:schoop/services/transaction_service_services.dart';
// import 'package:schoop/shared/theme.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:schoop/ui/services/service_success_page.dart';

// class ServicesTransactionPage extends StatefulWidget {
//   final String pembeli;
//   final String userID;
//   final String userDocID;
//   final String id;

//   ServicesTransactionPage({
//     Key? key,
//     required this.pembeli,
//     required this.userID,
//     required this.userDocID,
//     required this.id,
//   }) : super(key: key);

//   @override
//   _ServicesTransactionPageState createState() => _ServicesTransactionPageState(
//         this.pembeli,
//         this.userID,
//         this.userDocID,
//         this.id,
//       );
// }

// class _ServicesTransactionPageState extends State<ServicesTransactionPage> {
//   final String _pembeli;
//   final String _userID;
//   final String _userDocID;
//   final String _id;

//   bool _loading = false;

//   TextEditingController _location = new TextEditingController();
//   int _paymentRg = -1;
//   String? _selectedValuePayment;
//   final List<RadioGroup> _paymentMethod = [
//     RadioGroup(index: 1, text: "Cash"),
//     RadioGroup(index: 2, text: "Gopay"),
//     RadioGroup(index: 3, text: "Ovo"),
//     RadioGroup(index: 4, text: "Dana"),
//   ];

//   _ServicesTransactionPageState(
//     this._pembeli,
//     this._userID,
//     this._userDocID,
//     this._id,
//   );

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference services =
//         FirebaseFirestore.instance.collection('services');
//     final loadIndicator = Center(
//       child: CircularProgressIndicator(
//         valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
//       ),
//     );
//     String formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
//     return ScreenUtilInit(
//       designSize: Size(411, 731),
//       builder: () => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: HexColor("#F7F7FA"),
//           appBar: AppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: HexColor("#D44000"),
//                 )),
//             title: Text(
//               "Order Detail",
//               style: appBarTitle,
//             ),
//             centerTitle: true,
//             backgroundColor: HexColor("#F7F7FA"),
//             elevation: 0,
//           ),
//           body: GestureDetector(
//             onTap: (){
//               FocusScope.of(context).requestFocus(new FocusNode());
//             },
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 25.w, right: 25.w),
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream: services.doc(_id).snapshots(),
//                     builder: (_, snapshot) {
//                       if (snapshot.hasData) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 29.h),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10.r),
//                               child: ImageSlideshow(
//                                 width: 361.w,
//                                 height: 160.h,
//                                 initialPage: 0,
//                                 autoPlayInterval: 7000,
//                                 indicatorColor: HexColor("#C4C4C4"),
//                                 children: [
//                                   //Image for food Detail
//                                   Image.network(
//                                     snapshot.data!['image'],
//                                     fit: BoxFit.cover,
//                                   ),
//                                   Image.network(
//                                     snapshot.data!['image'],
//                                     fit: BoxFit.cover,
//                                   ),
//                                   Image.network(
//                                     snapshot.data!['image'],
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 23.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: 202.w,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         //food title
//                                         child: Text(
//                                           snapshot.data!['name'],
//                                           style: itemTitleTransaction,
//                                         )),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 106.w,
//                                   height: 26.h,
//                                   decoration: BoxDecoration(
//                                     color: HexColor("#303030").withOpacity(0.15),
//                                     borderRadius: BorderRadius.circular(7.r),
//                                   ),
//                                   child: Center(
//                                     child: Container(
//                                       width: 100.w,
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: FittedBox(
//                                             fit: BoxFit.scaleDown,
//                                             //price
//                                             child: Text(
//                                               "Rp. " +
//                                                   snapshot.data!['price']
//                                                       .toString(),
//                                               style: priceDetail,
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5.h),
//                             Container(
//                               width: 202.w,
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     //seller name
//                                     child: Text(
//                                       snapshot.data!['seller'],
//                                       style: sellerDetail,
//                                     )),
//                               ),
//                             ),
//                             SizedBox(height: 25.h),
//                             Text(
//                               "Identitas Pemesan",
//                               style: titleTransaction,
//                             ),
//                             SizedBox(height: 5.h),
//                             Container(
//                               height: 1.h,
//                               width: 197.w,
//                               color: HexColor("#303030"),
//                             ),
//                             SizedBox(height: 12.h),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Nama Pemesan : ",
//                                   style: textTransaction,
//                                 ),
//                                 Container(
//                                   width: 180.w,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         //pemesan name
//                                         child: Text(
//                                           _pembeli,
//                                           style: textTransaction,
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 7.h),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Tanggal Pemesan : ",
//                                   style: textTransaction,
//                                 ),
//                                 Container(
//                                   width: 180.w,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         //pemesan name
//                                         child: Text(
//                                           formattedDate,
//                                           style: textTransaction,
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 7.h),
//                             Text(
//                               'Alamat penjual : ' + snapshot.data!['address'],
//                               style: textTransaction,
//                             ),
//                             SizedBox(height: 7.h),
//                             Row(
//                               children: [
//                                 Text(
//                                   'Alamat pembeli : ',
//                                   style: textTransaction,
//                                 ),
//                                 Container(
//                                   width: 200.w,
//                                   child: TextField(
//                                     controller: _location,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18.sp,
//                                       color: Colors.black,
//                                     ),
//                                     decoration: InputDecoration(
//                                         hintText:
//                                             "masukkan alamat anda"),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 17.h),
//                             Text(
//                               "Metode Pembayaran",
//                               style: titleTransaction,
//                             ),
//                             SizedBox(height: 5.h),
//                             Container(
//                               height: 1.h,
//                               width: 224.w,
//                               color: HexColor("#303030"),
//                             ),
//                             SizedBox(
//                               height: 17.h,
//                             ),
//                             _buildRadioButton2(),
//                             SizedBox(height: 35.h),
//                             Text(
//                               "*Pastikan semua informasi pemesanan sudah sesuai",
//                               style: commentTransaction,
//                             ),
//                             SizedBox(height: 11.h),
//                             ButtonTheme(
//                               minWidth: 361.w,
//                               height: 39.h,
//                               child: RaisedButton(
//                                   color: HexColor("#474761"),
//                                   onPressed: () async {
//                                     setState(() {
//                                       _loading = true;
//                                     });
//                                     TransactionModelServices transactionservices =
//                                         TransactionModelServices(
//                                             userID: _userID,
//                                             userDocID: _userDocID,
//                                             userName: _pembeli,
//                                             methodPayment: _selectedValuePayment!,
//                                             startTime: DateTime.now(),
//                                             servicesID: snapshot.data!.id,
//                                             name: snapshot.data!['name'],
//                                             price: snapshot.data!['price'],
//                                             image: snapshot.data!['image'],
//                                             seller: snapshot.data!['seller'],
//                                             sellerID: snapshot.data!['sellerID']);
//                                     await TransactionServicesServices
//                                         .saveTransaction(
//                                             transactionservices,
//                                             snapshot.data!['stock'],
//                                             transactionservices.methodPayment,
//                                             _location.text);
//                                     Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ServiceSuccessPage(
//                                                     snapshot.data!['seller'],
//                                                     snapshot
//                                                         .data!['seller_number'],
//                                                     transactionservices
//                                                         .methodPayment,
//                                                     snapshot.data!['address'])));
//                                   },
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(7.r)),
//                                   child: _loading
//                                       ? loadIndicator
//                                       : Text(
//                                           'Konfirmasi',
//                                           style: buttonDetail,
//                                         )),
//                             ),
//                             SizedBox(height: 10.h),
//                           ],
//                         );
//                       } else {
//                         return CircularProgressIndicator();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRadioButton2() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: _paymentMethod
//           .map((programming) => Row(
//                 children: <Widget>[
//                   Radio(
//                     value: programming.index,
//                     groupValue: _paymentRg,
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     onChanged: (value) {
//                       setState(() {
//                         _paymentRg = value as int;
//                         _selectedValuePayment = programming.text;
//                       });
//                     },
//                   ),
//                   Text(programming.text),
//                 ],
//               ))
//           .toList(),
//     );
//   }

//   DropdownMenuItem<String> buildMenuItem(String itemLocation) =>
//       DropdownMenuItem(
//         value: itemLocation,
//         child: Text(
//           itemLocation,
//           style: textTransaction,
//         ),
//       );
// }

// class RadioGroup {
//   final int index;
//   final String text;
//   RadioGroup({required this.index, required this.text});
// }
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_this, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:schoop/models/transaction_model_services.dart';
import 'package:schoop/services/transaction_service_services.dart';
import 'package:schoop/shared/theme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:schoop/ui/services/service_success_page.dart';

class ServicesTransactionPage extends StatefulWidget {
  final String pembeli;
  final String userID;
  final String userDocID;
  final String id;

  ServicesTransactionPage({
    Key? key,
    required this.pembeli,
    required this.userID,
    required this.userDocID,
    required this.id,
  }) : super(key: key);

  @override
  _ServicesTransactionPageState createState() => _ServicesTransactionPageState(
        this.pembeli,
        this.userID,
        this.userDocID,
        this.id,
      );
}

class _ServicesTransactionPageState extends State<ServicesTransactionPage> {
  final String _pembeli;
  final String _userID;
  final String _userDocID;
  final String _id;
  bool isSelected = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  bool _loading = false;

  TextEditingController _location = new TextEditingController();
  int _paymentRg = -1;
  String? _selectedValuePayment;
  final List<RadioGroup> _paymentMethod = [
    RadioGroup(index: 1, text: "Cash"),
    RadioGroup(index: 2, text: "Gopay"),
    RadioGroup(index: 3, text: "Ovo"),
    RadioGroup(index: 4, text: "Dana"),
  ];

  _ServicesTransactionPageState(
    this._pembeli,
    this._userID,
    this._userDocID,
    this._id,
  );

  @override
  Widget build(BuildContext context) {
    CollectionReference services =
        FirebaseFirestore.instance.collection('services');
    final loadIndicator = Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
    String formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: HexColor("#F7F7FA"),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: HexColor("#D44000"),
                  )),
              title: Text(
                "Order Detail",
                style: appBarTitle,
              ),
              centerTitle: true,
              backgroundColor: HexColor("#F7F7FA"),
              elevation: 0,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: services.doc(_id).snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 29.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: ImageSlideshow(
                                width: 361.w,
                                height: 160.h,
                                initialPage: 0,
                                autoPlayInterval: 7000,
                                indicatorColor: HexColor("#C4C4C4"),
                                children: [
                                  //Image for food Detail
                                  Image.network(
                                    snapshot.data!['image'],
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    snapshot.data!['image'],
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    snapshot.data!['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 23.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 202.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        //food title
                                        child: Text(
                                          snapshot.data!['name'],
                                          style: itemTitleTransaction,
                                        )),
                                  ),
                                ),
                                Container(
                                  width: 106.w,
                                  height: 26.h,
                                  decoration: BoxDecoration(
                                    color:
                                        HexColor("#303030").withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 100.w,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            //price
                                            child: Text(
                                              "Rp. " +
                                                  snapshot.data!['price']
                                                      .toString(),
                                              style: priceDetail,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              width: 202.w,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    //seller name
                                    child: Text(
                                      snapshot.data!['seller'],
                                      style: sellerDetail,
                                    )),
                              ),
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Identitas Pemesan",
                              style: titleTransaction,
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 1.h,
                              width: 197.w,
                              color: HexColor("#303030"),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Text(
                                  "Nama Pemesan : ",
                                  style: textTransaction,
                                ),
                                Container(
                                  width: 180.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        //pemesan name
                                        child: Text(
                                          _pembeli,
                                          style: textTransaction,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              children: [
                                Text(
                                  "Tanggal Pemesan : ",
                                  style: textTransaction,
                                ),
                                Container(
                                  width: 180.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        //pemesan name
                                        child: Text(
                                          formattedDate,
                                          style: textTransaction,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Alamat penjual : ' + snapshot.data!['address'],
                              style: textTransaction,
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              children: [
                                Text(
                                  'Alamat pembeli : ',
                                  style: textTransaction,
                                ),
                                Container(
                                  width: 200.w,
                                  child: TextField(
                                    controller: _location,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "masukkan alamat anda"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 17.h),
                            Text(
                              "Metode Pembayaran",
                              style: titleTransaction,
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 1.h,
                              width: 224.w,
                              color: HexColor("#303030"),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            _buildRadioButton2(),
                            SizedBox(height: 35.h),
                            Text(
                              "*Pastikan semua informasi pemesanan sudah sesuai",
                              style: commentTransaction,
                            ),
                            SizedBox(height: 11.h),
                            ButtonTheme(
                              minWidth: 361.w,
                              height: 39.h,
                              child: RaisedButton(
                                  color: HexColor("#474761"),
                                  onPressed: isSelected == true
                                      ? () async {
                                          setState(() {
                                            _loading = true;
                                          });
                                          TransactionModelServices transactionservices =
                                              TransactionModelServices(
                                                  userID: _userID,
                                                  userDocID: _userDocID,
                                                  userName: _pembeli,
                                                  methodPayment:
                                                      _selectedValuePayment!,
                                                  startTime: DateTime.now(),
                                                  servicesID: snapshot.data!.id,
                                                  name: snapshot.data!['name'],
                                                  price:
                                                      snapshot.data!['price'],
                                                  image:
                                                      snapshot.data!['image'],
                                                  seller:
                                                      snapshot.data!['seller'],
                                                  sellerID: snapshot
                                                      .data!['sellerID']);
                                          await TransactionServicesServices
                                              .saveTransaction(
                                                  transactionservices,
                                                  snapshot.data!['stock'],
                                                  transactionservices
                                                      .methodPayment,
                                                  _location.text);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ServiceSuccessPage(
                                                          snapshot
                                                              .data!['seller'],
                                                          snapshot.data![
                                                              'seller_number'],
                                                          transactionservices
                                                              .methodPayment,
                                                          snapshot.data![
                                                              'address'])));
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  snackBarUnSuccesful());
                                        },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.r)),
                                  child: _loading
                                      ? loadIndicator
                                      : Text(
                                          'Konfirmasi',
                                          style: buttonDetail,
                                        )),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  snackBarUnSuccesful() {
    return SnackBar(
      content: Text(
        "Silakan Pilih Metode Yang Ada Terlebih Dahulu!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
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
                      if (_paymentMethod.isNotEmpty) {
                        setState(() {
                          isSelected = true;
                        });
                      }
                      setState(() {
                        _paymentRg = value as int;
                        _selectedValuePayment = programming.text;
                      });
                    },
                  ),
                  Text(programming.text),
                ],
              ))
          .toList(),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String itemLocation) =>
      DropdownMenuItem(
        value: itemLocation,
        child: Text(
          itemLocation,
          style: textTransaction,
        ),
      );
}

class RadioGroup {
  final int index;
  final String text;
  RadioGroup({required this.index, required this.text});
}
