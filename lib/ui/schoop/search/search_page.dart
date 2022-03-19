import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/book_card.dart';
import 'package:schoop/models/menu_book.dart';
import 'package:get/get.dart';
import 'package:schoop/ui/library/book/book_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic>? bookMap;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  void onSearch(String data) async {
    CollectionReference buku = _firestore.collection('buku');
    print('SEARCH : $data');
    if (data.length == 0) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitaliezd = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitaliezd);

      if (queryAwal.length == 0 && data.length == 1) {
        final keyNameResult = await buku
            .where('keyName', isEqualTo: data.substring(0, 1).toUpperCase())
            .get();

        print('TOTAL DATA : ${keyNameResult.docs.length}');

        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          print('QUERY RESULT : ');
          print(queryAwal);
        } else {
          print('TIDAK ADA DATA');
        }
      }
      if (queryAwal.length != 0) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          if (element['judul'].startsWith(capitaliezd)) {
            tempSearch.add(element);
          }
        });
      }
    }

    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context2) => ScreenUtilInit(
        designSize: Size(411, 731),
        builder: () => MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: HexColor("#39A2DB"),
                    )),
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 50.h, 30.w, 20.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      onChanged: (value) => onSearch(value),
                      controller: _search,
                      cursorColor: Colors.white,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        fillColor: HexColor("#39A2DB"),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        hintText: "Cari Buku..",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 20.h,
                        ),
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () {},
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),
            body: Obx(() => tempSearch.length == 0
                ? Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 100.h),
                          height: 300.h,
                          width: 300.w,
                          child: Image.asset('assets/Book.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 30.h, left: 8.w, right: 8.w, bottom: 3.h),
                          child: Text(
                            "Baca buku apa hari ini?",
                            style: GoogleFonts.poppins(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Cari dengan memasukkan judul buku.",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: tempSearch.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context2,
                              MaterialPageRoute(
                                  builder: (context) => BookPage(
                                        tempSearch[index]['id'].toString(),
                                        tempSearch[index]['image'],
                                        tempSearch[index]['judul'],
                                        tempSearch[index]['jumlahHalaman'],
                                        tempSearch[index]['stok'],
                                        tempSearch[index]['isKonvensional'],
                                        tempSearch[index]['penulis'],
                                        tempSearch[index]['sinopsis'],
                                        tempSearch[index]['ebook'],
                                      )));
                        },
                        child: BookCard(
                            menu: Menu(
                          id: tempSearch[index]['id'].toString(),
                          jumlahHalaman: tempSearch[index]['jumlahHalaman'],
                          stok: tempSearch[index]['stok'],
                          tahunTerbit: tempSearch[index]['tahunTerbit'],
                          image: tempSearch[index]['image'],
                          judul: tempSearch[index]['judul'],
                          penulis: tempSearch[index]['penulis'],
                          penerbit: tempSearch[index]['penerbit'],
                          sinopsis: tempSearch[index]['sinopsis'],
                          isPopular: tempSearch[index]['isPopular'],
                          categories: tempSearch[index]['categories'],
                          isKonvensional: tempSearch[index]['isKonvensional'],
                        ))),
                  )),
          ),
        ),
      ),
    );
  }
}
