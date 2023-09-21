import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';
import 'package:google_pay_task/resources/images.dart';

class PaymentBottomWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const PaymentBottomWidget({
    required this.accountNumber,
    required this.bankName,
    super.key,
  });

  final String accountNumber;
  final String bankName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: double.infinity,
          height: 1,
          child: ColoredBox(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      bankName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.fontMediumSmall,
                    ),
                    Text(
                      accountNumber,
                      style: AppTextStyles.fontMediumNormal,
                    ),
                  ],
                ),
              ),
              ColoredBox(
                color: Colors.white,
                child: Image.asset(
                  Images.upiIcon,
                  height: 30,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 40);
}
