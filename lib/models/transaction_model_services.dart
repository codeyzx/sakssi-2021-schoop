import 'package:equatable/equatable.dart';

class TransactionModelServices extends Equatable {
  final String userID;
  final String userDocID;
  final String userName;
  final String methodPayment;
  final DateTime startTime;

  // Book
  final String servicesID;
  final String name;
  final int price;
  final String image;
  final String seller;
  final String sellerID;

  TransactionModelServices({
    required this.userID,
    required this.userDocID,
    required this.userName,
    required this.methodPayment,
    required this.startTime,
    required this.servicesID,
    required this.name,
    required this.price,
    required this.image,
    required this.seller,
    required this.sellerID,
  });

  @override
  List<Object> get props => [
        userID,
        userDocID,
        userName,
        methodPayment,
        startTime,
        servicesID,
        name,
        price,
        image,
        seller,
        sellerID,
      ];
}
