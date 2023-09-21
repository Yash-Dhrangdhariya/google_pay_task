import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_pay_task/constants/app_constants.dart';
import 'package:google_pay_task/modules/payment/initiate_payment/bloc/initiate_payment_bloc.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final initiatePaymentBloc = context.read<InitiatePaymentBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '₹',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Flexible(
          child: AutoSizeTextField(
            style: AppTextStyles.amountField,
            controller: initiatePaymentBloc.amountTextController,
            textAlign: TextAlign.center,
            autofocus: true,
            textInputAction: TextInputAction.next,
            fullwidth: false,
            onChanged: (value) => AppConstants.validateAmount(
              value,
              initiatePaymentBloc.amountTextController,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                AppConstants.amountRegex,
              ),
            ],
            enableInteractiveSelection: false,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              hintText: '0',
              isDense: true,
              isCollapsed: true,
              hintStyle: AppTextStyles.amountField,
              border: InputBorder.none,
            ),
            focusNode: initiatePaymentBloc.amountFocusNode,
          ),
        ),
      ],
    );
  }
}
