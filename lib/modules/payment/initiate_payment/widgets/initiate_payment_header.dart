import 'package:flutter/material.dart';

class InitiatePaymentHeader extends StatelessWidget {
  const InitiatePaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.close,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.report_gmailerrorred,
                ),
              ),
              PopupMenuButton<int>(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    onTap: () {},
                    child: const Text('Get Help'),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: const Text('Send Feedback'),
                  ),
                ],
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
