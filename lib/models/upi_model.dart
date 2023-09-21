import 'package:flutter/cupertino.dart';

class UpiModel {
  UpiModel({
    required this.bankName,
    required this.accountNumber,
    required this.userName,
    required this.displayName,
    required this.pin,
    required this.amount,
    required this.dateTime,
    required this.upiId,
    required this.upiTransactionId,
    required this.transactionFailed,
  });

  UpiModel copyWith({
    String? bankName,
    String? userName,
    String? displayName,
    String? accountNumber,
    String? pin,
    String? refId,
    double? amount,
    DateTime? dateTime,
    String? upiId,
    int? upiTransactionId,
    bool? transactionFailed,
  }) {
    return UpiModel(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      userName: userName ?? this.userName,
      displayName: displayName ?? this.displayName,
      pin: pin ?? this.pin,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      upiId: upiId ?? this.upiId,
      upiTransactionId: upiTransactionId ?? this.upiTransactionId,
      transactionFailed: transactionFailed ?? this.transactionFailed,
    );
  }

  final String bankName;
  final String userName;
  final String displayName;
  final String accountNumber;
  final String pin;
  final String refId = UniqueKey().toString();
  final double amount;
  final DateTime dateTime;
  final String upiId;
  final int upiTransactionId;
  final bool transactionFailed;
}
