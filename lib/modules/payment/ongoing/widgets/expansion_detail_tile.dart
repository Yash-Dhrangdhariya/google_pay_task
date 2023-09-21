import 'package:flutter/material.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';

class ExpansionDetailTile extends StatelessWidget {
  const ExpansionDetailTile({
    required this.label,
    required this.detail,
    super.key,
  });

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                detail,
                style: AppTextStyles.fontMediumSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
