class BankModel {
  const BankModel({
    required this.name,
    required this.accountNumber,
    required this.accountType,
    required this.pin,
    required this.upiId,
    required this.avatar,
  });

  final String name;
  final String accountType;
  final String accountNumber;
  final String pin;
  final String upiId;
  final String avatar;
}
