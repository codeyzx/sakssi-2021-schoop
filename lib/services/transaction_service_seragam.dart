import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/transaction_model_seragam.dart';
import 'package:schoop/models/transaction_model_spp.dart';

class TransactionServicesSeragam {
  static CollectionReference transactionUserCollection =
      FirebaseFirestore.instance.collection('history_seragam');

  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveTransaction(
      TransactionModelSeragam transaction, int seragam, String id) async {
    await transactionUserCollection.doc().set({
      'userID': transaction.userID,
      'method': transaction.method,
      'startTime': transaction.startTime,
      'seragam': transaction.seragam,
      'status': false,
    });
  }
}
