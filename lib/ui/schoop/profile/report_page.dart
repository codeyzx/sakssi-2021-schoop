import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/shared/theme.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController email = TextEditingController();
  TextEditingController reportContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411, 731),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: HexColor("#F7F7FA"),
                body: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: ListView(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 348.h,
                          color: HexColor("#0C4271"),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 31.h,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 31.w),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                  ),
                                  Center(
                                    child: Text(
                                      "Laporkan Masalah",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                  child: Image.asset(
                                "assets/report-img.png",
                                width: 260.w,
                                height: 220.h,
                                fit: BoxFit.cover,
                              )),
                              SizedBox(height: 5.h),
                              Center(
                                child: Text(
                                  "24/7 Customer support",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 52.w, right: 52.w),
                          child: Center(
                            child: Text(
                              "Bantu kami membangun Schoop dengan melaporkan masalah",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.87),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 35.w, right: 35.w),
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: HexColor("#303030"),
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: HexColor("#303030"),
                                  width: 1,
                                ),
                              ),
                              prefixIcon: Padding(
                                child: IconTheme(
                                  data: IconThemeData(
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(
                                    Icons.email_rounded,
                                    color: HexColor("#F2C94C"),
                                  ),
                                ),
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                              ),
                              labelText: "Email Anda",
                              labelStyle: labelLogin,
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                              ),
                              hintText: "user@example.com",
                            ),
                          ),
                        ),
                        SizedBox(height: 22.h),
                        Padding(
                          padding: EdgeInsets.only(left: 35.w, right: 35.w),
                          child: SizedBox(
                            height: 134.h,
                            child: TextFormField(
                              controller: reportContent,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 100.h, left: 10.w),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  borderSide: BorderSide(
                                    color: HexColor("#303030"),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  borderSide: BorderSide(
                                    color: HexColor("#303030"),
                                    width: 1,
                                  ),
                                ),
                                labelText: "Report Bug",
                                labelStyle: labelLogin,
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                                hintText: "Masalah apa yang ingin dilaporkan?",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: ButtonTheme(
                            minWidth: 361.w,
                            height: 39.h,
                            child: RaisedButton(
                              color: HexColor("#3F3D56"),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r)),
                              child: Text(
                                "Kirim",
                                style: buttonDetail,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
