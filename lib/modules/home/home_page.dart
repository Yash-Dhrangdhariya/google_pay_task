import 'package:flutter/material.dart';
import 'package:google_pay_task/constants/app_routes.dart';
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/models/user_model.dart';
import 'package:google_pay_task/resources/images.dart';
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
          name: 'Yash',
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.paymentInitialPage,
            arguments: UserModel(
              displayName: 'Yash Gajjar',
              actualName: 'YASH HARSHADBHAI DHRANGDHARIYA',
              phoneNumber: '9664896592',
              accounts: const [
                BankModel(
                  name: 'State Bank of India',
                  accountNumber: '000000000001',
                  accountType: 'Saving',
                  pin: '111111',
                  avatar: Images.sbiIcon,
                  upiId: 'yashgajjar@oksbi',
                ),
                BankModel(
                  name: 'Industrial Credit and Investment Corporation of India',
                  accountNumber: '000000000002',
                  accountType: 'Saving',
                  pin: '1010',
                  avatar: Images.iciciIcon,
                  upiId: 'yashgajjar@icici',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
