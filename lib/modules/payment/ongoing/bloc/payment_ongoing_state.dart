import 'package:equatable/equatable.dart';

class PaymentOngoingState extends Equatable {
  const PaymentOngoingState(this.pin);

  final String? pin;

  @override
  List<Object?> get props => [pin];
}
