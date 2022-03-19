import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/transaction_shop.dart';

class TransactionServicesShop {
  static CollectionReference transactionshopCollection =
      FirebaseFirestore.instance.collection('history_Shop');

  static CollectionReference shopCollection =
      FirebaseFirestore.instance.collection('shop');

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveTransaction(
      TransactionShop transactionShop,
      int stock,
      String methodPayment,
      String methodOrder,
      String location) async {
    await transactionshopCollection.doc().set({
      'userID': transactionShop.userID,
      'userDocID': transactionShop.userDocID,
      'userName': transactionShop.userName,
      'method_order': methodOrder,
      'method_payment': methodPayment,
      'startTime': transactionShop.startTime,
      'ShopID': transactionShop.shopID,
      'name': transactionShop.name,
      'price': transactionShop.price,
      'image': transactionShop.image,
      'seller': transactionShop.seller,
      'sellerID': transactionShop.sellerID,
      'location': location,
      'status': false,
    });
  }

  static Future<void> returnTransaction(
    String userDocID,
    String shopId,
    String sellerID,
    int price,
  ) async {
    await shopCollection.doc(shopId).update({
      'stock': FieldValue.increment(-1),
    });
    await users.doc(userDocID).update({
      'pengeluaran': FieldValue.increment(price),
    });

    await users.doc(sellerID).update({
      'pendapatan': FieldValue.increment(price),
    });
  }
}
