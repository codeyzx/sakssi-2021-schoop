import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/transaction_model_services.dart';
import 'package:schoop/models/transaction_shop.dart';

class TransactionServicesServices {
  static CollectionReference transactionServicesCollection =
      FirebaseFirestore.instance.collection('history_services');

  static CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection('services');

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveTransaction(
      TransactionModelServices transactionservices,
      int stock,
      String methodPayment,
      String location) async {
    await transactionServicesCollection.doc().set({
      'userID': transactionservices.userID,
      'userDocID': transactionservices.userDocID,
      'userName': transactionservices.userName,
      'method_payment': methodPayment,
      'startTime': transactionservices.startTime,
      'servicesID': transactionservices.servicesID,
      'name': transactionservices.name,
      'price': transactionservices.price,
      'image': transactionservices.image,
      'seller': transactionservices.seller,
      'sellerID': transactionservices.sellerID,
      'location': location,
      'status': false,
    });
  }

  static Future<void> returnTransaction(
    String userDocID,
    String servicesID,
    String sellerID,
    int price,
  ) async {
    await servicesCollection.doc(servicesID).update({
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
