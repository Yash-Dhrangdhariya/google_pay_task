// NOTE: This is dummy data. For Simulation Purpose Only.
import 'package:google_pay_task/models/bank_model.dart';
import 'package:google_pay_task/models/user_model.dart';
import 'package:google_pay_task/resources/images.dart';

class AppData {
  static final demoUser = UserModel(
    displayName: 'Yash',
    actualName: 'YASH DHRANGDHARIYA',
    phoneNumber: '0000000000',
    accounts: const [
      BankModel(
        name: 'State Bank of India',
        accountNumber: '000000000001',
        accountType: 'Saving',
        pin: '000000',
        avatar: Images.sbiIcon,
        upiId: 'yash@bank1',
      ),
      BankModel(
        name: 'Industrial Credit and Investment Corporation of India',
        accountNumber: '000000000002',
        accountType: 'Saving',
        pin: '0000',
        avatar: Images.iciciIcon,
        upiId: 'yashg@bank2',
      ),
    ],
  );
}
