import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_event.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_state.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/payment_effect_view.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';
import 'package:google_pay_task/resources/images.dart';
import 'package:google_pay_task/widgets/bank_card.dart';

class PaymentMode extends StatelessWidget {
  const PaymentMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocSelector<InitiatePaymentBloc, InitiatePaymentState, bool>(
          selector: (state) => state.showAccounts,
          builder: (_, showAccount) {
            if (showAccount) {
              return const SizedBox();
            }
            return PaymentEffectView(
              initiatePaymentBloc: context.read<InitiatePaymentBloc>(),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedSize(
          duration: const Duration(
            milliseconds: 200,
          ),
          curve: Curves.ease,
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
                bottom: MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocSelector<InitiatePaymentBloc, InitiatePaymentState,
                      (bool, BankModel?)>(
                    selector: (state) => (
                      state.showAccounts,
                      state.paymentAccount,
                    ),
                    builder: (_, values) {
                      final initiatePaymentBloc =
                          context.read<InitiatePaymentBloc>();
                      if (values.$1) {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemCount: initiatePaymentBloc.user.accounts.length,
                          itemBuilder: (_, index) {
                            final bank =
                                initiatePaymentBloc.user.accounts[index];
                            return BankCard(
                              onTap: () => initiatePaymentBloc.add(
                                ReviewPayment(
                                  paymentAccount: bank,
                                  showAccounts: false,
                                ),
                              ),
                              bank: bank,
                            );
                          },
                        );
                      }
                      if (values.$2 != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 20,
                              ),
                              child: Text(
                                'Choose account to pay with',
                                style: AppTextStyles.fontMediumNormal,
                              ),
                            ),
                            BankCard(
                              onTap: () => initiatePaymentBloc.add(
                                ReviewPayment(
                                  showAccounts: true,
                                ),
                              ),
                              bank: values.$2!,
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: FilledButton.tonal(
                      onPressed: () => context.read<InitiatePaymentBloc>().add(
                            PaymentStatusEvent(
                              status: PaymentStatus.processing,
                            ),
                          ),
                      child: Text(
                        // ignore: lines_longer_than_80_chars
                        'Pay ₹${context.read<InitiatePaymentBloc>().state.paymentAmount}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Powered By',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.fontSmall,
                  ),
                  Image.asset(
                    Images.upiIcon,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
