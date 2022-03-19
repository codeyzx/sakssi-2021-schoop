import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/ui/library/book/categories_details.dart';

import 'menu_categories.dart';

class CategoriesHomeCard extends StatelessWidget {
  final MenuCategories menuCategories;

  const CategoriesHomeCard({Key? key, required this.menuCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.h,
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoriesDetails(
                    nama: menuCategories.nama,
                    isKonvensional: menuCategories.isKonvensional);
              }));
            },
            icon: Image.network(menuCategories.image),
            iconSize: 50.sp,
          ),
          Text(menuCategories.nama),
        ],
      ),
    );
  }
}
