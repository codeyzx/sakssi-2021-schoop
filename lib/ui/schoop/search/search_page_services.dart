import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:schoop/shared/theme.dart';
import 'package:schoop/ui/services/service_detail_page.dart';
import 'package:schoop/ui/shop/shop_detail_page.dart';

class SearchPageServices extends StatefulWidget {
  const SearchPageServices({Key? key}) : super(key: key);

  @override
  _SearchPageServicesState createState() => _SearchPageServicesState();
}

class _SearchPageServicesState extends State<SearchPageServices> {
  Map<String, dynamic>? shopMap;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  void onSearch(String data) async {
    CollectionReference services = _firestore.collection('services');
    print('SEARCH : $data');
    if (data.length == 0) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitaliezd = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitaliezd);

      if (queryAwal.length == 0 && data.length == 1) {
        final keyNameResult = await services
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
          if (element['name'].startsWith(capitaliezd)) {
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
    CollectionReference services = _firestore.collection('services');
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
                              hintText: "Cari food..",
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
                  body: Obx(
                    () => tempSearch.length == 0
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
                                      top: 30.h,
                                      left: 8.w,
                                      right: 8.w,
                                      bottom: 3.h),
                                  child: Text(
                                    "Makan apa hari ini?",
                                    style: GoogleFonts.poppins(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "Cari dengan memasukkan nama makanan atau minuman.",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: tempSearch.length,
                            itemBuilder: (context, index) => StreamBuilder<
                                    QuerySnapshot>(
                                stream: services
                                    .where('name',
                                        isEqualTo: tempSearch[index]['name'])
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: (snapshot.data!)
                                          .docs
                                          .map(
                                            (e) => GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context2,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceDetailPage(
                                                                e.id,
                                                                tempSearch[
                                                                        index]
                                                                    ['image'],
                                                                tempSearch[
                                                                        index]
                                                                    ['name'],
                                                                tempSearch[
                                                                        index]
                                                                    ['price'],
                                                                tempSearch[
                                                                        index]
                                                                    ['stock'],
                                                                tempSearch[
                                                                        index]
                                                                    ['seller'],
                                                                tempSearch[
                                                                        index][
                                                                    'seller_number'],
                                                                tempSearch[
                                                                        index]
                                                                    ['desc'])));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.w,
                                                    right: 25.w,
                                                    top: 10.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ServiceDetailPage(
                                                                e.id,
                                                                tempSearch[
                                                                        index]
                                                                    ['image'],
                                                                tempSearch[
                                                                        index]
                                                                    ['name'],
                                                                tempSearch[
                                                                        index]
                                                                    ['price'],
                                                                tempSearch[
                                                                        index]
                                                                    ['stock'],
                                                                tempSearch[
                                                                        index]
                                                                    ['seller'],
                                                                tempSearch[
                                                                        index]
                                                                    ['seller_number'],
                                                                tempSearch[
                                                                        index]
                                                                    ['desc'])));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      //image item
                                                      Container(
                                                        width: 108.w,
                                                        height: 108.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadiusDirectional
                                                                  .circular(
                                                                      5.r),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: HexColor(
                                                                      "#864000")
                                                                  .withOpacity(
                                                                      0.25),
                                                              blurRadius: 15,
                                                              offset:
                                                                  Offset(0, 5),
                                                            ),
                                                          ],
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                tempSearch[
                                                                        index]
                                                                    ['image']),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            tempSearch[index]
                                                                ['name'],
                                                            style:
                                                                categoryTitle,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            "Rp. ${tempSearch[index]['price'].toString()}",
                                                            style: itemTitle,
                                                          ),
                                                          Text(
                                                            "Detail Pesanan :",
                                                            style: itemTitle,
                                                          ),
                                                          Text(
                                                            tempSearch[index]
                                                                ['seller'],
                                                            style: itemSubTitle,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            tempSearch[index][
                                                                'seller_number'],
                                                            style: itemSubTitle,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            tempSearch[index]
                                                                    ['stock']
                                                                .toString(),
                                                            style: itemSubTitle,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
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
                                }),
                          ),
                  ),
                ),
              ),
            ));
  }
}
