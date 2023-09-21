import 'package:google_pay_task/models/bank_model.dart';

class UserModel {
  UserModel({
    required this.displayName,
    required this.actualName,
    required this.phoneNumber,
    required this.accounts,
  });

  String displayName;
  String actualName;
  String phoneNumber;
  List<BankModel> accounts;
}
