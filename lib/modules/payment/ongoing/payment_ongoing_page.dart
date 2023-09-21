import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/constants/app_constants.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_bloc.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_event.dart';
import 'package:google_pay_task/modules/payment/ongoing/bloc/payment_ongoing_state.dart';
import 'package:google_pay_task/modules/payment/ongoing/widgets/custom_keyboard.dart';
import 'package:google_pay_task/modules/payment/ongoing/widgets/expansion_detail_tile.dart';
import 'package:google_pay_task/modules/payment/ongoing/widgets/payment_bottom_widget.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class PaymentOngoingPage extends StatelessWidget {
  const PaymentOngoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentOngoingBloc = context.read<PaymentOngoingBloc>();
    final upi = paymentOngoingBloc.upi;
    return Scaffold(
      appBar: AppBar(
        bottom: PaymentBottomWidget(
          accountNumber: 'XXXX${upi.accountNumber.substring(8, 12)}',
          bankName: upi.bankName,
        ),
      ),
      body: ColoredBox(
        color: Colors.grey,
        child: Center(
          child: ColoredBox(
            color: Colors.white,
            child: Stack(
              children: [
                // Positioned.fill(
                //   child: ColoredBox(
                //     color: Colors.black.withOpacity(0.5),
                //   ),
                // ),

                Positioned.fill(
                  top: 60,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ENTER ${upi.pin.length} DIGIT UPI PIN',
                                  style: AppTextStyles.fontMediumNormal,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: upi.pin.length,
                                    itemBuilder: (_, index) => SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: BlocSelector<PaymentOngoingBloc,
                                          PaymentOngoingState, int>(
                                        selector: (state) =>
                                            state.pin?.length ?? 0,
                                        builder: (_, values) => DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: values > index
                                                ? Colors.indigo.shade900
                                                : Colors.white,
                                            border: Border.all(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (_, __) => const SizedBox(
                                      width: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: ColoredBox(
                                      color:
                                          Colors.orangeAccent.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error,
                                              color:
                                                  Colors.orangeAccent.shade700,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'You are SENDING '
                                                '${upi.amount} '
                                                'from your account to '
                                                '${upi.userName}',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomKeyboard(
                            text: context.read<PaymentOngoingBloc>().text,
                            limit: upi.pin.length,
                            onTap: (value) => paymentOngoingBloc.add(
                              PaymentOngoingEvent(value),
                            ),
                            onSubmit: () {
                              if (paymentOngoingBloc.state.pin?.length ==
                                  upi.pin.length) {
                                if (paymentOngoingBloc.state.pin == upi.pin) {
                                  Navigator.pop(
                                    context,
                                    upi,
                                  );
                                } else {
                                  Navigator.pop(
                                    context,
                                    upi.copyWith(
                                      transactionFailed: true,
                                    ),
                                  );
                                }
                              } else {
                                AppConstants.showSnackBar(
                                  'Please enter 6 digit UPI PIN',
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: ExpansionTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'To',
                              style: AppTextStyles.fontMediumSmall,
                            ),
                            Text(
                              upi.userName.length > 18
                                  ? '${upi.userName.substring(0, 18)}...'
                                  : upi.userName.toUpperCase(),
                              style: AppTextStyles.fontMediumSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sending',
                              style: AppTextStyles.fontMediumSmall,
                            ),
                            Text(
                              '₹ ${upi.amount}',
                              style: AppTextStyles.fontMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      ExpansionDetailTile(
                        label: 'PAYING TO',
                        detail: upi.userName.toUpperCase(),
                      ),
                      ExpansionDetailTile(
                        label: 'AMOUNT',
                        detail: upi.amount.toString(),
                      ),
                      const ExpansionDetailTile(
                        label: 'DETAILS',
                        detail: 'NONE',
                      ),
                      ExpansionDetailTile(
                        label: 'REF ID',
                        detail: upi.refId,
                      ),
                      ExpansionDetailTile(
                        label: 'ACCOUNT',
                        detail:
                            '${upi.bankName.replaceAll(' ', '_').toUpperCase()}'
                            ' XXXXXX${upi.accountNumber.substring(8, 12)}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
