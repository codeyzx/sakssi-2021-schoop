import 'package:schoop/models/menu_book.dart';
import 'package:schoop/models/book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'book_page.dart';

class CategoriesDetails extends StatefulWidget {
  final String nama;
  final bool isKonvensional;

  const CategoriesDetails(
      {Key? key, required this.nama, required this.isKonvensional})
      : super(key: key);

  @override
  _CategoriesDetailsState createState() =>
      _CategoriesDetailsState(nama, isKonvensional);
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  String _nama;
  bool _isKonvensional;

  _CategoriesDetailsState(
    this._nama,
    this._isKonvensional,
  );

  @override
  Widget build(BuildContext context) {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('buku');
    final Query isCategories = categories.where('categories', isEqualTo: _nama);
    final Query isKonvensional =
        isCategories.where('isKonvensional', isEqualTo: _isKonvensional);
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: HexColor("#39A2DB"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Kategori $_nama",
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
              StreamBuilder<QuerySnapshot>(
                  stream: isKonvensional.snapshots(),
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
                                            builder: (context) => BookPage(
                                                  e.id,
                                                  e['image'],
                                                  e['judul'],
                                                  e['jumlahHalaman'],
                                                  e['stok'],
                                                  e['isKonvensional'],
                                                  e['penulis'],
                                                  e['sinopsis'],
                                                  e['ebook'],
                                                )));
                                  },
                                  child: BookCard(
                                      menu: Menu(
                                    id: e.id,
                                    jumlahHalaman: e['jumlahHalaman'],
                                    stok: e['stok'],
                                    tahunTerbit: e['tahunTerbit'],
                                    image: e['image'],
                                    judul: e['judul'],
                                    penulis: e['penulis'],
                                    penerbit: e['penerbit'],
                                    sinopsis: e['sinopsis'],
                                    isPopular: e['isPopular'],
                                    categories: e['categories'],
                                    isKonvensional: e['isKonvensional'],
                                  ))),
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
