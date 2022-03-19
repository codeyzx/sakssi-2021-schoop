import 'package:equatable/equatable.dart';

class TransactionModelSpp extends Equatable {
  final String userID;
  final String method;
  final DateTime startTime;

  // Payment
  final int spp;

  TransactionModelSpp({
    required this.userID,
    required this.method,
    required this.startTime,
    required this.spp,
  });

  @override
  List<Object> get props => [userID, method, startTime, spp];
}
