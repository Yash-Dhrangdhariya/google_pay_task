import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class PaymentLoadingIndicator extends StatelessWidget {
  const PaymentLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final initiatePaymentBloc = context.read<InitiatePaymentBloc>();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).viewPadding.bottom + 10,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 26,
                height: 26,
                child: RepaintBoundary(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Paying ${initiatePaymentBloc.user.displayName}'
                  '  ₹${initiatePaymentBloc.state.paymentAmount}',
                  style: AppTextStyles.fontMediumNormal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
