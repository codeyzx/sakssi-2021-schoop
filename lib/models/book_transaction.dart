class BookTransaction {
  String userID;
  String judul;
  String userName;
  int stok;
  String image;

  BookTransaction(
      {required this.judul,
      required this.stok,
      required this.image,
      required this.userID,
      required this.userName});
}
