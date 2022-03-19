part of 'services.dart';

class BookService {
  static CollectionReference buku =
      FirebaseFirestore.instance.collection('book');
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> saveBook(String id, BookTransaction book) async {
    await buku.doc().set({
      'id': book.userID,
      'userName': book.userName,
      'judul': book.judul,
      'image': book.image,
      'stok': book.stok,
    });
  }

  static Future<List<BookTransaction>> getTickets(String userId) async {
    QuerySnapshot snapshot = await users.get();
    var documents =
        snapshot.docs.where((document) => document['nis'] == userId);

    List<BookTransaction> books = [];
    for (var document in documents) {
      books.add(BookTransaction(
          judul: document['judul'],
          image: document['image'],
          stok: document['stok'],
          userName: document['userName'],
          userID: document['userID']));
    }

    return books;
  }
}
