// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:schoop/ui/services/services_transaction_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailPage extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final int price;
  final int stock;
  final String seller;
  final String sellerNumber;
  final String desc;
  const ServiceDetailPage(this.id, this.image, this.name, this.price,
      this.stock, this.seller, this.sellerNumber, this.desc,
      {Key? key})
      : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState(
      id, image, name, price, stock, seller, sellerNumber, desc);
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  String _id;
  String _image;
  String _name;
  int _price;
  int _stock;
  String _seller;
  String _sellerNumber;
  String _desc;

  _ServiceDetailPageState(
    this._id,
    this._image,
    this._name,
    this._price,
    this._stock,
    this._seller,
    this._sellerNumber,
    this._desc,
  );
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411, 731),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(
                child: Scaffold(
                  body: Container(
                    width: 1.sw,
                    height: 1.sh,
                    child: Stack(
                      children: [
                        ImageSlideshow(
                          width: 1.sw,
                          height: 342.h,
                          initialPage: 0,
                          autoPlayInterval: 7000,
                          indicatorColor: HexColor("#C4C4C4"),
                          children: [
                            //Image for food Detail
                            Image.network(
                              _image,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              _image,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              _image,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 1.sw,
                            height: 406.h,
                            decoration: BoxDecoration(
                              color: HexColor("#F7F7FA"),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25.w, right: 25.w, top: 22.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          //image profile seller
                                          Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/61/61205.png",
                                            width: 18.sp,
                                            height: 18.sp,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 7.w,
                                          ),
                                          Container(
                                            width: 226.w,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  //seller name
                                                  child: Text(
                                                    _seller,
                                                    style: sellerDetail,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Stok : ", style: subDetail),
                                          //15 below change with variable
                                          Text(
                                            _stock.toString(),
                                            style: subDetail,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 226.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              //food title
                                              child: Text(
                                                _name,
                                                style: titleDetail,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        width: 106.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          color: HexColor("#303030")
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
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
                                                    "Rp" + _price.toString(),
                                                    style: priceDetail,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18.h),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/star-icon.png",
                                        width: 15.w,
                                        height: 14.31.h,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8.33.w,
                                      ),
                                      Text(
                                        "Trusted",
                                        style: subDetail,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Container(
                                    width: 361.w,
                                    height: 1.h,
                                    color: HexColor("#303030"),
                                  ),
                                  SizedBox(height: 12.h),
                                  //deskripsi detail
                                  Container(
                                    width: 360.w,
                                    height: 140.h,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        _desc,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      launchChatWhatsapp(
                                          number: "+62$_sellerNumber",
                                          message: "Halo");
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Hubungi Penjual",
                                            style: subDetail),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Image.asset(
                                          "assets/wa-icon.png",
                                          width: 21.w,
                                          height: 21.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  //button beli
                                  BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                    if (state is AuthSuccess) {
                                      return ButtonTheme(
                                        minWidth: 361.w,
                                        height: 39.h,
                                        child: RaisedButton(
                                          color: HexColor("#0C4271"),
                                          onPressed: () {
                                            (_stock == 0)
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        snackBarUnSuccesful())
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ServicesTransactionPage(
                                                        pembeli:
                                                            state.user.name,
                                                        userID: state.user.nis,
                                                        userDocID:
                                                            state.user.id,
                                                        id: _id,
                                                      ),
                                                    ),
                                                  );
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.r)),
                                          child: Text(
                                            "BELI",
                                            style: buttonDetail,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: SizedBox(
                    height: 55.h,
                    width: 55.w,
                    child: FittedBox(
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        elevation: 0,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startTop,
                ),
              ),
            ));
  }
}

snackBarUnSuccesful() {
  return SnackBar(
    content: Text(
      'Stok tidak tersedia',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(),
  );
}

void launchChatWhatsapp({@required number, @required message}) async {
  String url = "whatsapp://send?phone=$number&text=$message";
  await canLaunch(url) ? launch(url) : print("Tidak bisa buka whatsapp");
}
