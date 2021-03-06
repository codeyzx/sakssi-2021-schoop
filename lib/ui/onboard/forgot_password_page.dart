import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/shared/theme.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _email = new TextEditingController();

  bool _loading = false;

  void forgotPassword(BuildContext context) async {
    FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate()) {
      form!.save();
      setState(() {
        _loading = true;
      });
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccesful());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBarUnSuccesful());
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String? emailValidator(value) {
      var pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty) return '*Masukkan Email Anda!';
      if (!regex.hasMatch(value))
        return '*Mohon Masukkan Email yang Valid!';
      else
        return null;
    }

    final logoPintas = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 120.9,
        child: Image.asset('assets/icon_pintas.png',
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4),
      ),
    );

    final loadIndicator = Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );

    final next = Container(
      width: double.infinity,
      height: 55.h,
      child: RaisedButton(
        onPressed: () {
          forgotPassword(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor("#3a7bd5"), HexColor("#468df0")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "SELANJUTNYA",
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
      builder: () => SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Lupa Kata Sandi",
            style: TextStyle(
              fontSize: 23.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: HexColor("#3a7bd5")),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 30.h),
            child: Center(
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: logoPintas,
                    ),
                    Container(
                      child: Text(
                        "Silakan masukkan alamat email dari akun SCHOOP Anda untuk mendapatkan email berisi Link Reset Kata Sandi ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 75.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 5.w),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(
                                color: HexColor("#303030"),
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
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
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            ),
                            labelText: "Email",
                            labelStyle: labelLogin,
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                            ),
                            hintText: "user@example.com",
                          ),
                          controller: _email,
                          validator: emailValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: _loading
                          ? loadIndicator
                          : Container(
                              child: next,
                            ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      )),
    );
  }

  snackBarSuccesful() {
    return SnackBar(
      content: Text(
        "Email Berisi Password Reset Telah Dikirim! Mohon Di Cek di Gmail Anda!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.lightBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
    );
  }

  snackBarUnSuccesful() {
    return SnackBar(
      content: Text(
        "Tidak ada pengguna SCHOOP di akun ini!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
    );
  }
}
