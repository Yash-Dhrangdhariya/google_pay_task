import 'package:flutter/material.dart';
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class BankCard extends StatelessWidget {
  const BankCard({
    required this.onTap,
    required this.bank,
    super.key,
  });

  final void Function() onTap;
  final BankModel bank;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        bank.avatar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bank.name} ••••'
                        '${bank.accountNumber.substring(
                          bank.accountNumber.length - 4,
                        )}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.fontMediumNormal,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${bank.accountType} Account',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
