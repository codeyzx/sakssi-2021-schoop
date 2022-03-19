import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/categories_card.dart';
import 'package:schoop/models/menu_categories.dart';

import 'categories_details.dart';

class CategoriesPageDigital extends StatelessWidget {
  const CategoriesPageDigital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories_book');
    final Query isDigital =
        categories.where('isKonvensional', isEqualTo: false);
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
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
              "Kategori",
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
          body: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: isDigital.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: (snapshot.data!)
                            .docs
                            .map(
                              (e) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoriesDetails(
                                                  nama: e['nama'],
                                                  isKonvensional:
                                                      e['isKonvensional'])),
                                    );
                                  },
                                  child: CategoriesCard(
                                    menuCategories: MenuCategories(
                                        isKonvensional: e['isKonvensional'],
                                        id: e['id'],
                                        image: e['image'],
                                        nama: e['nama']),
                                  )),
                            )
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
