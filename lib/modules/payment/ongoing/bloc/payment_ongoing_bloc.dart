import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/models/upi_model.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_event.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_state.dart';

class PaymentOngoingBloc
    extends Bloc<PaymentOngoingEvent, PaymentOngoingState> {
  PaymentOngoingBloc(this.upi)
      : super(
          const PaymentOngoingState(null),
        ) {
    on<PaymentOngoingEvent>(
      (event, emit) {
        emit(
          PaymentOngoingState(event.input),
        );
      },
    );
  }

  final List<String> text = [];

  late UpiModel upi;

  @override
  void onChange(Change<PaymentOngoingState> change) {
    super.onChange(change);
    log(
      'Change: $change',
      name: 'PaymentOngoingState',
    );
  }

  @override
  void onEvent(PaymentOngoingEvent event) {
    log(
      'Event: $event',
      name: 'PaymentOngoingState',
    );
    super.onEvent(event);
  }
}
