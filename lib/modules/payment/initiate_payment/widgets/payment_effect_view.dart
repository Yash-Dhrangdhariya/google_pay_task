import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_event.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_state.dart';

class PaymentEffectView extends StatelessWidget {
  const PaymentEffectView({
    required this.initiatePaymentBloc,
    super.key,
  });

  final InitiatePaymentBloc initiatePaymentBloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SizedBox(
              width: 58,
              height: 58,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: const ColoredBox(
                  color: Colors.black12,
                ),
              ),
            ),
          ),
          PageView.builder(
            controller: initiatePaymentBloc.effectPageController,
            itemCount: Colors.primaries.length + 1,
            onPageChanged: (index) {
              initiatePaymentBloc.add(
                SelectPaymentEffect(
                  index: index,
                  color: index == 0 ? null : Colors.primaries[index - 1],
                ),
              );
            },
            itemBuilder: (_, index) {
              return BlocSelector<InitiatePaymentBloc, InitiatePaymentState,
                  int>(
                selector: (state) => state.effectIndex,
                builder: (_, effectIndex) {
                  final current =
                      initiatePaymentBloc.state.effectIndex == index;
                  return Center(
                    child: AnimatedContainer(
                      width: current ? 46 : 40,
                      height: current ? 46 : 40,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: const Duration(seconds: 1),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: index == 0
                              ? Colors.grey
                              : Colors.primaries[index - 1],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 8,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 2.6,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
