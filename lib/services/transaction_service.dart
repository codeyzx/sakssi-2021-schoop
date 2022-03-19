part of 'services.dart';

class TransactionServices {
  static CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('history');

  static CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('buku');

  static CollectionReference libraryCollection =
      FirebaseFirestore.instance.collection('perpustakaan');

  static Future<void> saveTransaction(
      TransactionModel transaction, int stok, int kursi) async {
    if (transaction.method == TransactionMethod.baca_di_perpustakaan) {
      await bookCollection.doc(transaction.bookID).update({
        'stok': stok - 1,
      });

      await libraryCollection.doc('1').update({
        'kursi_tersedia': kursi - 1,
      });
    } else {
      await bookCollection.doc(transaction.bookID).update({
        'stok': stok - 1,
      });
    }

    await transactionCollection.doc().set({
      'userID': transaction.userID,
      'method': transaction.method == TransactionMethod.bawa_pulang
          ? "Bawa Pulang"
          : "Baca di Perpustakaan",
      'startTime': transaction.startTime,
      'endTime': transaction.endTime,
      'bookID': transaction.bookID,
      'judul': transaction.judul,
      'jumlahHalaman': transaction.jumlahHalaman,
      'image': transaction.image,
      'penulis': transaction.penulis,
      'denda': transaction.denda,
      'status_buku': false
    });
  }

  static Future<void> returnTransaction(
      TransactionModel transaction, String idTransaction) async {
    if (transaction.method == TransactionMethod.baca_di_perpustakaan) {
      await libraryCollection.doc('1').update({
        'kursi_tersedia': FieldValue.increment(1),
      });
    } else {
      await bookCollection.doc(transaction.bookID).update({
        'stok': FieldValue.increment(1),
      });
    }

    await transactionCollection.doc(idTransaction).update({
      'status_buku': true,
    });
  }
}
