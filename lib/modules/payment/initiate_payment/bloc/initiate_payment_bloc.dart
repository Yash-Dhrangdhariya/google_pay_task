import 'dart:developer' as debug;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/constants/app_constants.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/models/upi_model.dart';
import 'package:google_pay_task/models/user_model.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_event.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_state.dart';

enum PaymentStatus { initiate, ongoing, processing, success, failed }

class InitiatePaymentBloc
    extends Bloc<InitiatePaymentEvent, InitiatePaymentState> {
  InitiatePaymentBloc(this.user)
      : super(
          InitiatePaymentState(
            effectIndex: 0,
            showAccounts: false,
            paymentAccount:
                user.accounts.isNotEmpty ? user.accounts.elementAt(0) : null,
            paymentStatus: PaymentStatus.initiate,
          ),
        ) {
    debug.log('Initialized', name: 'PaymentInitialBloc');

    effectPageController = PageController(
      initialPage: state.effectIndex,
      viewportFraction: 0.16,
    );

    amountFocusNode.addListener(
      _amountFocusListener,
    );

    on<ReviewPayment>(
      _reviewPayment,
    );

    on<PaymentStatusEvent>(
      _paymentStatusEvent,
    );

    on<CallNext>(
      _callNext,
    );

    on<SelectPaymentEffect>(
      _selectPaymentEffect,
    );
  }

  final amountTextController = TextEditingController();
  final amountFocusNode = FocusNode();
  late final PageController effectPageController;

  final UserModel user;
  UpiModel? transactionResponse;

  void _reviewPayment(
    ReviewPayment event,
    Emitter<InitiatePaymentState> emit,
  ) {
    if (event.showAccounts) {
      emit(
        state.copyWith(
          showAccounts: event.showAccounts,
          paymentStatus: PaymentStatus.ongoing,
          // hasFocus: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          showAccounts: event.showAccounts,
          paymentStatus: PaymentStatus.ongoing,
          paymentAccount: event.paymentAccount,
          // hasFocus: false,
        ),
      );
    }
  }

  Future<void> _paymentStatusEvent(
    PaymentStatusEvent event,
    Emitter<InitiatePaymentState> emit,
  ) async {
    if (event.status == PaymentStatus.processing) {
      emit(
        state.copyWith(
          paymentStatus: PaymentStatus.processing,
        ),
      );
      final amountInDouble = double.parse(state.paymentAmount!);
      if (amountInDouble > 0) {
        final upi = UpiModel(
          bankName: state.paymentAccount?.name ?? '',
          accountNumber: state.paymentAccount?.accountNumber ?? '',
          userName: user.actualName,
          pin: state.paymentAccount?.pin ?? '',
          amount: amountInDouble,
          upiId: state.paymentAccount?.upiId ?? '',
          dateTime: DateTime.now(),
          displayName: user.displayName,
          upiTransactionId: Random().nextInt(4294967296),
          transactionFailed: false,
        );
        await Future.delayed(
            const Duration(
              seconds: 3,
            ), () async {
          final result =
              await AppConstants.navigationKey.currentState?.pushNamed(
            AppRoutes.paymentOngoingPage,
            arguments: upi,
          );

          await Future<void>.delayed(
            const Duration(seconds: 2),
          );
          if (result != null) {
            transactionResponse = result as UpiModel;
            emit(
              state.copyWith(
                paymentStatus: (transactionResponse?.transactionFailed ?? true)
                    ? PaymentStatus.failed
                    : PaymentStatus.success,
              ),
            );
          } else {
            emit(
              state.copyWith(
                paymentStatus: PaymentStatus.ongoing,
              ),
            );
          }
        });
      }
    } else {
      emit(
        state.copyWith(
          paymentStatus: event.status,
        ),
      );
    }
  }

  void _callNext(
    CallNext event,
    Emitter<InitiatePaymentState> emit,
  ) {
    if (amountFocusNode.hasFocus) {
      final isEmpty = amountTextController.text.trim().isEmpty;
      if (isEmpty) {
        AppConstants.showSnackBar(
          'Payment must be at least 1',
        );
        emit(
          state.copyWith(
            paymentAmount: amountTextController.text.trim(),
          ),
        );
      } else {
        final amount = double.parse(amountTextController.text.trim());
        if (amount == 0.0) {
          AppConstants.showSnackBar(
            'Payment must be at least 1',
          );
        } else {
          amountFocusNode.unfocus();
          emit(
            state.copyWith(
              paymentAmount: amountTextController.text.trim(),
              paymentStatus: PaymentStatus.ongoing,
              // hasFocus: false,
            ),
          );
        }
      }
    } else {
      emit(
        state.copyWith(
          paymentAmount: amountTextController.text.trim(),
        ),
      );
    }
  }

  void _selectPaymentEffect(
    SelectPaymentEffect event,
    Emitter<InitiatePaymentState> emit,
  ) {
    emit(
      state.copyWith(
        effectIndex: event.index,
        effectColor: event.color,
      ),
    );
  }

  void _amountFocusListener() {
    if (amountFocusNode.hasFocus) {
      add(
        PaymentStatusEvent(
          status: PaymentStatus.initiate,
        ),
      );
    } else {
      add(
        PaymentStatusEvent(
          status: PaymentStatus.ongoing,
        ),
      );
    }
  }

  void dispose() {
    amountFocusNode.dispose();
    amountTextController.dispose();
    effectPageController.dispose();
    debug.log('Disposed', name: 'PaymentInitialBloc');
  }

  @override
  void onChange(Change<InitiatePaymentState> change) {
    super.onChange(change);
    debug.log(
      'Change: $change',
      name: 'PaymentInitialBloc',
    );
  }

  @override
  void onEvent(InitiatePaymentEvent event) {
    debug.log(
      'Event: $event',
      name: 'PaymentInitialBloc',
    );
    super.onEvent(event);
  }
}
