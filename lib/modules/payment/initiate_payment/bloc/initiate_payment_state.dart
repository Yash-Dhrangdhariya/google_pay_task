import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';

class InitiatePaymentState extends Equatable {
  const InitiatePaymentState({
    required this.showAccounts,
    required this.effectIndex,
    required this.paymentStatus,
    this.paymentAccount,
    this.effectColor,
    this.paymentAmount,
  });

  final String? paymentAmount;
  final bool showAccounts;
  final MaterialColor? effectColor;
  final int effectIndex;
  final BankModel? paymentAccount;
  final PaymentStatus paymentStatus;

  InitiatePaymentState copyWith({
    String? paymentAmount,
    bool? showAccounts,
    MaterialColor? effectColor,
    int? effectIndex,
    BankModel? paymentAccount,
    PaymentStatus? paymentStatus,
  }) {
    return InitiatePaymentState(
      paymentAmount: paymentAmount ?? this.paymentAmount,
      showAccounts: showAccounts ?? this.showAccounts,
      effectColor: effectColor ?? this.effectColor,
      effectIndex: effectIndex ?? this.effectIndex,
      paymentAccount: paymentAccount ?? this.paymentAccount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  @override
  List<Object?> get props => [
        paymentAmount,
        effectColor,
        effectIndex,
        paymentAccount,
        showAccounts,
        paymentStatus,
      ];
}
