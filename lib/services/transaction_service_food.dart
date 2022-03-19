import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/transaction_model_food.dart';

class TransactionServicesFood {
  static CollectionReference transactionFoodCollection =
      FirebaseFirestore.instance.collection('history_food');

  static CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food');

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveTransaction(
      TransactionModelFood transactionFood,
      int stock,
      String methodPayment,
      String methodOrder,
      String location) async {
    await transactionFoodCollection.doc().set({
      'userID': transactionFood.userID,
      'userDocID': transactionFood.userDocID,
      'userName': transactionFood.userName,
      'method_order': methodOrder,
      'method_payment': methodPayment,
      'startTime': transactionFood.startTime,
      'foodID': transactionFood.foodID,
      'name': transactionFood.name,
      'price': transactionFood.price,
      'image': transactionFood.image,
      'seller': transactionFood.seller,
      'sellerID': transactionFood.sellerID,
      'location': location,
      'status': false,
    });
  }

  static Future<void> returnTransaction(
    String userDocID,
    String foodID,
    String sellerID,
    int price,
  ) async {
    await foodCollection.doc(foodID).update({
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
