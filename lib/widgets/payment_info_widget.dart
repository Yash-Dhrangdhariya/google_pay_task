import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';
import 'package:google_pay_task/widgets/user_tile.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({
    required this.name,
    required this.number,
    required this.bankingName,
    super.key,
  });

  final String name;
  final String number;
  final String bankingName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserTile(
          name: name,
        ),
        Text(
          'Paying $name',
          textAlign: TextAlign.center,
          style: AppTextStyles.fontMediumNormal,
        ),
        Text(
          '+91 ${number.substring(0, 5)} ${number.substring(5, 10)}',
          textAlign: TextAlign.center,
          style: AppTextStyles.fontMediumSmall,
        ),
        Text(
          'Banking name: $bankingName',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
