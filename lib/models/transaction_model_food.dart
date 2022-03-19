import 'package:equatable/equatable.dart';

class TransactionModelFood extends Equatable {
  final String userID;
  final String userDocID;
  final String userName;
  final String methodOrder;
  final String methodPayment;
  final DateTime startTime;

  // Book
  final String foodID;
  final String name;
  final int price;
  final String image;
  final String seller;
  final String sellerID;

  TransactionModelFood({
    required this.userID,
    required this.userDocID,
    required this.userName,
    required this.methodOrder,
    required this.methodPayment,
    required this.startTime,
    required this.foodID,
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
        foodID,
        name,
        price,
        image,
        seller,
        sellerID,
      ];
}
