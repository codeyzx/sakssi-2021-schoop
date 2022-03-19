import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/onboard/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _nis = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirm = new TextEditingController();
  String errorMsg = "";

  bool _loading = false;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _email.dispose();
    _nis.dispose();
    _password.dispose();
    _confirm.dispose();
  }

  void signup() async {
    FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate()) {
      form!.save();
      setState(() {
        _loading = true;
      });
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccesful());
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return NavBar();
        }));
      });
    } catch (error) {
      print(error);
      if (this.mounted) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBarUnSuccesful());
      }
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _repeatpasswordVisible = false;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final loadIndicator = Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );

    final loginDesc = Text(
      'Sudah Punya Akun Schoop?',
      style: TextStyle(
        fontSize: 15.sp,
        fontFamily: 'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.w400,
        wordSpacing: 1.0,
      ),
      maxLines: 1,
      textAlign: TextAlign.center,
    );

    final kelogin = FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
      },
      child: Text(
        'MASUK',
        style: TextStyle(
          color: Colors.blue,
          fontFamily: 'Poppins',
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final daftarPintas =
        BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccess) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/nav-bar', (route) => false);
      } else if (state is AuthFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kRedColor,
            content: Text(state.error),
          ),
        );
      }
    }, builder: (context, state) {
      return Container(
        width: double.infinity,
        height: 55.h,
        child: RaisedButton(
          onPressed: isButtonActive == true
              ? () {
                  context.read<AuthCubit>().signUp(
                      email: _email.text,
                      password: _password.text,
                      name: _name.text,
                      nis: _nis.text);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBarSuccesful());
                  Timer(Duration(seconds: 3), () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return NavBar();
                    }));
                  });
                  return signup();
                }
              : () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBarUnSuccesful());
                },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isButtonActive == true
                      ? [HexColor("#3a7bd5"), HexColor("#468df0")]
                      : [HexColor("#F2353B"), HexColor("#F3494E")],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                "DAFTAR",
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
    });

    String? emailValidator(value) {
      var pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty) return 'Masukkan Email Anda!';
      if (!regex.hasMatch(value))
        return 'Mohon Masukkan Email yang Valid!';
      else
        return null;
    }

    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HexColor("#F7F7FA"),
            title: Text(
              "Daftar",
              style: TextStyle(
                fontSize: 25.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: HexColor("#3a7bd5")),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/login-bg.png",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 40.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 5.w),
                            child: TextFormField(
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
                                      Icons.person,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                labelText: "Nama",
                                labelStyle: labelLogin,
                                hintText: "User",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                              ),
                              controller: _name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Masukkan Nama Lengkap Anda!";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSaved: (input) {
                                _name.text = input!;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
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
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                labelText: "Email",
                                labelStyle: labelLogin,
                                hintText: "user@example.com",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                              ),
                              controller: _email,
                              validator: emailValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 5.w),
                            child: TextFormField(
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
                                      Icons.account_box,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                labelText: "NIS",
                                labelStyle: labelLogin,
                                hintText: "202186xxxx",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                              ),
                              controller: _nis,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Masukkan NIS Anda!";
                                }

                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSaved: (input) {
                                _nis.text = input!;
                              },
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 5.w),
                            child: TextFormField(
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
                                      Icons.lock_rounded,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                labelText: "Kata Sandi",
                                labelStyle: labelLogin,
                                hintText: "Example : User_123",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Kata Sandi tidak boleh kosong';
                                if (value.length < 6)
                                  return 'Minimal Kata Sandi 6 Karakter';
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: !_passwordVisible,
                              controller: _password,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 5.w),
                            child: TextFormField(
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
                                      Icons.lock_rounded,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                labelText: "Ulang Kata Sandi",
                                labelStyle: labelLogin,
                                hintText: "Ulangi Kata Sandi Anda!",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _repeatpasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _repeatpasswordVisible =
                                          !_repeatpasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Konfirmasi Kata Sandi harus diisi';
                                if (_confirm.text != _password.text)
                                  return 'Kata Sandi yang dimasukkan tidak sesuai';
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: !_repeatpasswordVisible,
                              controller: _confirm,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: FormField<bool>(
                              builder: (state) {
                                return CheckboxListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Saya setuju dengan",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: " Syarat & Ketentuan",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Colors.blue,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url =
                                                    'https://www.termsfeed.com/live/60d38d77-41a0-4e29-a88a-fb9bfe23e56b';
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceWebView: true,
                                                    forceSafariVC: true,
                                                    enableJavaScript: true,
                                                  );
                                                }
                                              },
                                          ),
                                          TextSpan(
                                            text: " dan",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: " Kebijakan Privasi",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Colors.blue,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url =
                                                    'https://www.privacypolicyonline.com/live.php?token=ABTlX4Y7xgfh3OFjbfBqNt98vozrY1KG';
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceWebView: true,
                                                    forceSafariVC: true,
                                                    enableJavaScript: true,
                                                  );
                                                }
                                              },
                                          ),
                                          TextSpan(
                                            text: " yang berlaku",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 5.w),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: _acceptTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _acceptTerms = value!;
                                      state.didChange(value);
                                      if (value == true) {
                                        isButtonActive = true;
                                      } else {
                                        isButtonActive = false;
                                      }
                                    });
                                  },
                                  subtitle: Text(
                                    state.errorText ?? '',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Theme.of(context).errorColor,
                                    ),
                                  ),
                                );
                              },
                              validator: (value) {
                                if (!_acceptTerms) {
                                  return '*Anda Perlu Menyetujui S&K!';
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          _loading ? loadIndicator : daftarPintas,
                          SizedBox(
                            height: 9.h,
                          ),
                          Row(
                            children: [
                              Container(
                                child: loginDesc,
                              ),
                              Container(
                                child: kelogin,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

snackBarSuccesful() {
  return SnackBar(
    content: Text(
      "Daftar Akun PINTAS Berhasil!",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.lightBlue,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(23),
    ),
  );
}

snackBarUnSuccesful() {
  return SnackBar(
    content: Text(
      "Mohon Semua Diisi Field Diisi Dengan Benar!",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(23),
    ),
  );
}
