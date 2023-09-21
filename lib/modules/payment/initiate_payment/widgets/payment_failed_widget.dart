import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_colors.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';
import 'package:google_pay_task/resources/images.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.viewPaddingOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: const ColoredBox(
                color: AppColors.upiWarningColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Wrong UPI PIN',
                              style: AppTextStyles.upiWarning,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'After 3 wrong tries, '
                              "you'll be asked to reset your PIN. "
                              'Note that this is not your ATM PIN.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
              onPressed: () => Navigator.maybePop(context),
              child: const Text(
                'Try Again!',
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
    );
  }
}
