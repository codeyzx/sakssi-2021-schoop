import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/transaction_model_spp.dart';

class TransactionServicesSpp {
  static CollectionReference transactionUserCollection =
      FirebaseFirestore.instance.collection('history_spp');

  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveTransaction(
      TransactionModelSpp transaction, int spp, String id) async {
    await transactionUserCollection.doc().set({
      'userID': transaction.userID,
      'method': transaction.method,
      'startTime': transaction.startTime,
      'spp': transaction.spp,
      'status': false,
    });
  }
}
