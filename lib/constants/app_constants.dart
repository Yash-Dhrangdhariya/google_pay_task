import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_colors.dart';

class AppConstants {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static const double maxAmountAllowed = 10000000;

  static final amountRegex = RegExp(r'^\d+\.?\d{0,2}');

  static void showSnackBar(String message) => scaffoldMessengerKey.currentState
    ?..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.snackBarColor,
      ),
    );

  static void validateAmount(
    String value,
    TextEditingController controller,
  ) {
    if (value.isNotEmpty) {
      final valueInDouble = double.parse(value);
      if (double.parse(value[0]) == 0) {
        if (value.length > 1) {
          if (value[1] != '0') {
            controller
              ..text = value.substring(1, value.length)
              ..selection = TextSelection.collapsed(offset: value.length - 1);
          } else {
            controller
              ..text = '0'
              ..selection = const TextSelection.collapsed(offset: 1);
          }
        }
      } else if (valueInDouble > AppConstants.maxAmountAllowed) {
        AppConstants.showSnackBar(
          'You can not send amount more than 1,00,00,000',
        );
        if (!(valueInDouble <= maxAmountAllowed)) {
          controller
            ..text = value.substring(0, value.length - 1)
            ..selection = TextSelection.collapsed(
              offset: value.length - 1,
            );
        }
      }
    }
  }
}
