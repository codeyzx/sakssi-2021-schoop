import 'package:equatable/equatable.dart';

class TransactionShop extends Equatable {
  final String userID;
  final String userDocID;
  final String userName;
  final String methodOrder;
  final String methodPayment;
  final DateTime startTime;

  // Book
  final String shopID;
  final String name;
  final int price;
  final String image;
  final String seller;
  final String sellerID;

  TransactionShop({
    required this.userID,
    required this.userDocID,
    required this.userName,
    required this.methodOrder,
    required this.methodPayment,
    required this.startTime,
    required this.shopID,
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
        methodOrder,
        methodPayment,
        startTime,
        shopID,
        name,
        price,
        image,
        seller,
        sellerID,
      ];
}
