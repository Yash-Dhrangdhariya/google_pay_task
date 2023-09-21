import 'package:flutter/material.dart';
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';

sealed class InitiatePaymentEvent {}

class ReviewPayment extends InitiatePaymentEvent {
  ReviewPayment({
    required this.showAccounts,
    this.paymentAccount,
  });

  final BankModel? paymentAccount;
  final bool showAccounts;
}

class CallNext extends InitiatePaymentEvent {}

class PaymentStatusEvent extends InitiatePaymentEvent {
  PaymentStatusEvent({
    required this.status,
  });

  final PaymentStatus status;
}

class SelectPaymentEffect extends InitiatePaymentEvent {
  SelectPaymentEffect({
    required this.index,
    required this.color,
  });

  final int index;
  final MaterialColor? color;
}
