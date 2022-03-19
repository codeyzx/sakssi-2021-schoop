import 'package:equatable/equatable.dart';

enum TransactionMethod { bawa_pulang, baca_di_perpustakaan }

class TransactionModel extends Equatable {
  final String userID;
  final TransactionMethod method;
  final DateTime startTime;
  final DateTime endTime;
  final int denda;

  // Book
  final String bookID;
  final String judul;
  final int jumlahHalaman;
  final String image;
  final String penulis;

  TransactionModel({
    required this.userID,
    required this.method,
    required this.startTime,
    required this.endTime,
    required this.denda,
    required this.bookID,
    required this.judul,
    required this.jumlahHalaman,
    required this.image,
    required this.penulis,
  });

  @override
  List<Object> get props => [
        userID,
        method,
        startTime,
        endTime,
        denda,
        bookID,
        judul,
        jumlahHalaman,
        image,
        penulis,
      ];
}
