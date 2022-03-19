import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/cubit/page_cubit.dart';
import 'package:schoop/models/user_model.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/onboard/login_screen.dart';
import 'package:schoop/ui/schoop/profile/help_schoop_page.dart';
import 'package:schoop/ui/schoop/profile/report_page.dart';
// import 'package:schoop/ui/schoop/profile/report_page.dart';
import 'editProfilePage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Builder(
      builder: (context2) => ScreenUtilInit(
        designSize: Size(411, 731),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.h),
              child: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: HexColor("#303030"),
                flexibleSpace: Column(
                  children: [
                    SizedBox(
                      height: 71.h,
                    ),
                    Center(
                        child: Text(
                      "Profile",
                      style: appbarTitle,
                    )),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 26.w, right: 26.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                    if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kRedColor,
                          content: Text(state.error),
                        ),
                      );
                    } else if (state is AuthInitial) {
                      context.read<PageCubit>().setPage(0);
                      Navigator.pushReplacement(context2,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    }
                  }, builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthSuccess) {
                      void signOut() {
                        context.read<AuthCubit>().signOut();
                      }

                      return StreamBuilder<QuerySnapshot>(
                          stream: users
                              .where('nis', isEqualTo: state.user.nis)
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: (snapshot.data!)
                                    .docs
                                    .map(
                                      (e) => Container(
                                        width: 351.w,
                                        height: 59.h,
                                        margin: EdgeInsets.only(top: 27.h),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color: HexColor("#303030"))),
                                        ),
                                        child: ListView(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 40.w,
                                                      height: 40.w,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              new DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: e['picture'] ==
                                                                    ""
                                                                ? NetworkImage(
                                                                    'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                                                                  )
                                                                : NetworkImage(e[
                                                                    'picture']),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 17.w,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 149.w,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                e['name'],
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.87),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 149.w,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                e['email'],
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.87),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 93.w,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#FF3334"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                  ),
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        signOut();
                                                      },
                                                      child: Text(
                                                        "Sign Out",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          });
                    } else {
                      return SizedBox();
                    }
                  }),
                  SizedBox(height: 20.h),
                  Text(
                    "Account",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.black.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 10.h),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfilePage();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditProfilePage();
                                      }));
                                    },
                                    icon: Icon(
                                      Icons.person,
                                      size: 30.sp,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  Text(
                                    "Edit Profile",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditProfilePage();
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#F2C94C"),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HelpSchoopPage();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HelpSchoopPage();
                                      }));
                                    },
                                    icon: Icon(
                                      Icons.help,
                                      size: 30.sp,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  Text(
                                    "Help",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HelpSchoopPage();
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#F2C94C"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "General",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.black.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 10.h),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
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
                                    icon: Icon(
                                      Icons.library_books_rounded,
                                      size: 30.sp,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  Text(
                                    "Terms & Condition",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
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
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#F2C94C"),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
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
                                    icon: Icon(
                                      Icons.privacy_tip_rounded,
                                      size: 30.sp,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  Text(
                                    "Privacy & Policy",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
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
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#F2C94C"),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReportPage()));
                                    },
                                    icon: Icon(
                                      Icons.bug_report_rounded,
                                      size: 30.sp,
                                      color: HexColor("#F2C94C"),
                                    ),
                                  ),
                                  Text(
                                    "Report Problems",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Container()));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#F2C94C"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
