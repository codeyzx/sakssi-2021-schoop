import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoop/cubit/auth_cubit.dart';

// ignore: must_be_immutable
class FoodForm extends StatefulWidget {
  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  File? image;

  final TextEditingController imageController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        this.image = File(image.path);
        setState(() {});
      }
    } on PlatformException catch (e) {
      print('Failed to Pick Image: $e');
    }
  }

  Future<String> uploadImage() async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('seller')
        .child('${DateTime.now().toIso8601String() + p.basename(image!.path)}');

    final results = await ref.putFile(File(image!.path));
    final imageUrl = await results.ref.getDownloadURL();

    print('Link Download : $imageUrl');
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference food = FirebaseFirestore.instance.collection('food');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Jual Makanan'),
        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(-5, 0),
                  blurRadius: 15,
                  spreadRadius: 3)
            ]),
            width: double.infinity,
            height: 1000.h,
            child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              if (state is AuthSuccess) {
                statusUpload() async {}

                return Row(
                  children: [
                    SizedBox(
                      width: 350,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Stack(
                            children: [
                              image != null
                                  ? Container(
                                      width: 128.w,
                                      height: 128.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: image != null
                                              ? FileImage(image!)
                                                  as ImageProvider
                                              : NetworkImage(""),
                                        ),
                                      ),
                                    )
                                  : TextField(
                                      readOnly: true,
                                      style: GoogleFonts.poppins(),
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          hintText: "Gambar Makanan",
                                          suffixIcon: Positioned(
                                              bottom: 2,
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
                                                        color: Colors.blue[900],
                                                        child: IconButton(
                                                            onPressed: () {
                                                              pickImage();
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                    ),
                                                  )))),
                                    ),
                            ],
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: nameController,
                            decoration:
                                InputDecoration(hintText: "Nama Makanan"),
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: priceController,
                            decoration:
                                InputDecoration(hintText: "Harga Makanan"),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: stockController,
                            decoration:
                                InputDecoration(hintText: "Stok Makanan"),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: descController,
                            decoration:
                                InputDecoration(hintText: "Deskripsi Makanan"),
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: addressController,
                            decoration:
                                InputDecoration(hintText: "Alamat Toko"),
                          ),
                          TextField(
                            style: GoogleFonts.poppins(),
                            controller: phoneController,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "+62",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          HexColor("#303030").withOpacity(0.50),
                                    ),
                                  ),
                                ),
                                hintText: "857xxxxx"),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 100,
                            width: 300,
                            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Colors.blue[900],
                                child: Text(
                                  'Add Data',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  String url = await uploadImage();
                                  if (uploadImage().toString().isEmpty) {
                                    imageController.text = "Gambar Makanan";
                                  } else if (uploadImage()
                                      .toString()
                                      .isNotEmpty) {
                                    setState(() {
                                      imageController.text = url;
                                    });
                                  }
                                  food.add({
                                    'image': imageController.text,
                                    'name': nameController.text,
                                    'price': int.tryParse(priceController.text),
                                    'stock': int.tryParse(stockController.text),
                                    'desc': descController.text,
                                    'address': addressController.text,
                                    'id': FieldValue.increment(1),
                                    'seller': state.user.name,
                                    'sellerID': state.user.id,
                                    'seller_number': phoneController.text
                                  });

                                  imageController.text = '';
                                  nameController.text = '';
                                  priceController.text = '';
                                  stockController.text = '';
                                  descController.text = '';
                                  addressController.text = '';
                                  phoneController.text = '';

                                  if (image != null) {
                                    uploadImage();
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            })));
  }
}
