import 'package:equatable/equatable.dart';

class TransactionModelSeragam extends Equatable {
  final String userID;
  final String method;
  final DateTime startTime;

  // Payment
  final int seragam;

  TransactionModelSeragam({
    required this.userID,
    required this.method,
    required this.startTime,
    required this.seragam,
  });

  @override
  List<Object> get props => [userID, method, startTime, seragam];
}
