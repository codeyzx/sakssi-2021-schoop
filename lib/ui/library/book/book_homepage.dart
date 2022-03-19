import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/library/book/book_type_page.dart';
import 'package:schoop/models/news_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/ui/library/book/categories_details.dart';
import 'package:schoop/ui/library/book/book_page.dart';
import 'package:schoop/ui/library/book/categories_page_digital.dart';
import 'package:schoop/ui/schoop/search/search_page.dart';

class BookHomePage extends StatefulWidget {
  BookHomePage({Key? key}) : super(key: key);

  @override
  _BookHomePageState createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {
  final imageList = imagesItem;
  final categoriesImage = categoriesItem;

  @override
  Widget build(BuildContext context) {
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('categories_book');
    final Query ascCategories =
        categories.limit(4).orderBy('id', descending: false);
    final Query descCategories =
        categories.limit(3).orderBy('id', descending: true);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference noticeCollection = firestore.collection('buku');
    final Query isPopular =
        noticeCollection.where("isPopular", isEqualTo: true);
    final Query ebook =
        noticeCollection.where("isKonvensional", isEqualTo: false);
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor('#F7F7FA'),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: HexColor("#39A2DB"),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  "Mau baca apa nih?",
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 0,
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: 133.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: HexColor("#39A2DB"),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchPage();
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 45.h),
                          width: 377.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pemrograman Dasar...",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: Colors.black.withOpacity(0.50),
                                      fontWeight: FontWeight.w400),
                                ),
                                Image.asset(
                                  "assets/Search.png",
                                  width: 18.w,
                                  height: 18.h,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40.h, left: 30.w, right: 40.w, bottom: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#333740"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: ascCategories.snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 30.w, right: 30.w, bottom: 0.h),
                                      width: 374.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                                (snapshot.data!).docs.map((e) {
                                              return Flexible(
                                                flex: 1,
                                                child: Container(
                                                  width: 70.w,
                                                  height: 110.h,
                                                  margin: EdgeInsets.only(
                                                      right: 10.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return CategoriesDetails(
                                                                nama: e['nama'],
                                                                isKonvensional:
                                                                    e['isKonvensional']);
                                                          }));
                                                        },
                                                        icon: Image.network(
                                                            e['icon']),
                                                        iconSize: 50.sp,
                                                      ),
                                                      Text(
                                                        e['nama'],
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        StreamBuilder<QuerySnapshot>(
                            stream: descCategories.snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 30.w, right: 30.w, bottom: 0.h),
                                      width: 374.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 5.h,
                                              left: 10.w,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: (snapshot.data!)
                                                  .docs
                                                  .map((e) {
                                                return Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 70.w,
                                                    height: 110.h,
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    child: Column(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return CategoriesDetails(
                                                                  nama:
                                                                      e['nama'],
                                                                  isKonvensional:
                                                                      e['isKonvensional']);
                                                            }));
                                                          },
                                                          icon: Image.network(
                                                              e['icon']),
                                                          iconSize: 50.sp,
                                                        ),
                                                        Text(e['nama']),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 15.h,
                                              right: 25.w,
                                              left: 5.w,
                                            ),
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return BookTypePage();
                                                    }));
                                                  },
                                                  icon: Image.network(
                                                      'https://cdn-icons-png.flaticon.com/512/512/512142.png'),
                                                  iconSize: 40.sp,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 5.h,
                                                  ),
                                                  child: Text("More"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                    Container(
                      width: 1.sw,
                      height: 1.h,
                      color: Colors.black.withOpacity(0.15),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 30.h, left: 30.w, right: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Books",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: HexColor("#333740"),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //slider popular item - aku isi 3
                            StreamBuilder<QuerySnapshot>(
                              stream: isPopular.snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: (snapshot.data!)
                                        .docs
                                        .map(
                                          (e) => Container(
                                            margin:
                                                EdgeInsets.only(right: 20.w),
                                            width: 109.w,
                                            height: 195.h,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookPage(
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      child: Image.network(
                                                        e['image'],
                                                        width: 109.w,
                                                        height: 150.h,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Text(
                                                    e['judul'],
                                                    style: popularTitleBook,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    e['penulis'],
                                                    style: popularSubTitleBook,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ebook",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: HexColor("#333740"),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CategoriesPageDigital();
                              }));
                            },
                            child: Text(
                              "View all",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#828285"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //slider ebook item - aku isi 3

                            StreamBuilder<QuerySnapshot>(
                              stream: ebook.snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: (snapshot.data!)
                                        .docs
                                        .map(
                                          (e) => Container(
                                            margin:
                                                EdgeInsets.only(right: 20.w),
                                            width: 109.w,
                                            height: 192.h,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookPage(
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      child: Image.network(
                                                        e['image'],
                                                        width: 109.w,
                                                        height: 150.h,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Text(
                                                    e['judul'],
                                                    style: popularTitleBook,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    e['penulis'],
                                                    style: popularSubTitleBook,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
