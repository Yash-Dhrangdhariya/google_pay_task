import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_event.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_state.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/amount_text_field.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/initiate_payment_header.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/payment_failed_widget.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/payment_loading_indicator.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/widgets/payment_mode_widget.dart';
import 'package:google_pay_task/widgets/payment_info_widget.dart';

class InitiatePage extends StatelessWidget {
  const InitiatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
          child: BlocSelector<InitiatePaymentBloc, InitiatePaymentState,
              MaterialColor?>(
            selector: (state) => state.effectColor,
            builder: (_, effectColor) {
              return ColoredBox(
                color: effectColor?.shade200 ?? Colors.white,
              );
            },
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: BlocSelector<InitiatePaymentBloc,
              InitiatePaymentState, PaymentStatus>(
            selector: (state) => state.paymentStatus,
            builder: (_, status) {
              if (status == PaymentStatus.initiate) {
                return FloatingActionButton(
                  onPressed: () => context.read<InitiatePaymentBloc>().add(
                        CallNext(),
                      ),
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: PaymentInfo(
                        name: context
                            .read<InitiatePaymentBloc>()
                            .user
                            .displayName,
                        number: context
                            .read<InitiatePaymentBloc>()
                            .user
                            .phoneNumber,
                        bankingName:
                            context.read<InitiatePaymentBloc>().user.actualName,
                      ),
                    ),
                    const AmountTextField(),
                  ],
                ),
                const InitiatePaymentHeader(),
                BlocConsumer<InitiatePaymentBloc, InitiatePaymentState>(
                  listener: (context, state) {
                    if (state.paymentStatus == PaymentStatus.success) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.paymentSuccessPage,
                        arguments: context
                            .read<InitiatePaymentBloc>()
                            .transactionResponse,
                      );
                    }
                  },
                  listenWhen: (previous, current) =>
                      previous.paymentStatus != current.paymentStatus,
                  buildWhen: (previous, current) =>
                      previous.paymentStatus != current.paymentStatus,
                  builder: (_, state) {
                    switch (state.paymentStatus) {
                      case PaymentStatus.processing:
                        return const PaymentLoadingIndicator();
                      case PaymentStatus.ongoing:
                        return const Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: PaymentMode(),
                        );
                      case PaymentStatus.failed:
                        return const Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: PaymentFailed(),
                        );
                      // ignore: no_default_cases
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
