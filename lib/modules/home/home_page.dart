import 'package:flutter/material.dart';
import 'package:google_pay_task/constants/app_data.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/widgets/user_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: UserTile(
          name: AppData.demoUser.displayName,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.paymentInitialPage,
            arguments: AppData.demoUser,
          ),
        ),
      ),
    );
  }
}
