import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/models/user_model.dart';
import 'package:schoop/models/user_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController nis = new TextEditingController();

  Future updateEmail() async {
    try {
      User? auth = FirebaseAuth.instance.currentUser;
      await auth!.updateEmail(email.text);
    } catch (e) {
      print("error");
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        this.image = File(image.path);
        setState(() {});
      }

      // final imageTemporary = File(image.path);
      // setState(() {
      //   this.image = imageTemporary;
      // });
    } on PlatformException catch (e) {
      print('Failed to Pick Image: $e');
    }
  }

  Future<String> uploadImage() async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(image!.path)}');

    final results = await ref.putFile(File(image!.path));
    final imageUrl = await results.ref.getDownloadURL();

    print('Link Download : $imageUrl');
    return imageUrl;
  }

  Future updateProfile() async {
    Map<String, dynamic> data = Map();
    if (image != null) {
      String url = await uploadImage();
      data['picture'] = url;
      data['name'] = name.text;
      data['email'] = email.text;
      data['nis'] = nis.text;
    } else {
      data['name'] = name.text;
      data['email'] = email.text;
      data['nis'] = nis.text;
    }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }

  UserModel? user;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => Builder(
        builder: (context) => Scaffold(
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
              "Edit Profile",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return StreamBuilder<QuerySnapshot>(
                    stream: users
                        .where('nis', isEqualTo: state.user.nis)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: (snapshot.data!).docs.map((e) {
                            name.text = e['name'];
                            email.text = e['email'];
                            nis.text = e['nis'];
                            return ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Center(
                                        child: Stack(
                                      children: [
                                        ClipOval(
                                            child: Container(
                                          width: 128.w,
                                          height: 128.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(e[
                                                          'picture'] ==
                                                      ''
                                                  ? 'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg'
                                                  : e['picture']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Container(
                                            width: 128.w,
                                            height: 128.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: (image != null)
                                                    ? FileImage(image!)
                                                        as ImageProvider
                                                    : NetworkImage(
                                                        state.user.picture,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        )),
                                        Positioned(
                                            bottom: 0,
                                            right: 4,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  color: Colors.white,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Container(
                                                      color: Colors.blue,
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            pickImage();
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                )))
                                      ],
                                    )),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "NIS",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 25.w),
                                            child: TextField(
                                                controller: nis,
                                                onChanged: (val) {
                                                  nis.text = val;
                                                  nis.selection = TextSelection
                                                      .fromPosition(
                                                          TextPosition(
                                                              offset: nis.text
                                                                  .length));
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                obscureText: false,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: "2021xxxxxx",
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color: HexColor("#55585F"),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            HexColor("#39A2DB"),
                                                        width: 2),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  suffixIcon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "Nama",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 25.w),
                                            child: TextField(
                                                controller: name,
                                                onChanged: (val) {
                                                  name.text = val;
                                                  name.selection = TextSelection
                                                      .fromPosition(
                                                          TextPosition(
                                                              offset: name.text
                                                                  .length));
                                                },
                                                obscureText: false,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: "User",
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color: HexColor("#55585F"),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            HexColor("#39A2DB"),
                                                        width: 2),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  suffixIcon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "Email",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 25.w),
                                            child: TextField(
                                                controller: email,
                                                // readOnly: true,
                                                onChanged: (val) {
                                                  email.text = val;
                                                  email.selection =
                                                      TextSelection
                                                          .fromPosition(
                                                              TextPosition(
                                                                  offset: email
                                                                      .text
                                                                      .length));
                                                },
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                obscureText: false,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: state.user.email,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color: HexColor("#55585F"),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            HexColor("#39A2DB"),
                                                        width: 2),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  suffixIcon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  // confirmUpdateDialog(context);
                                                  if (image != null) {
                                                    uploadImage();
                                                  }
                                                  updateProfile();
                                                  updateEmail();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NavBar()));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 25.w),
                                                  width: 167.w,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("39A2DB"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Simpan",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    });
              } else {
                return SizedBox();
              }
            },
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
