import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class InitiatePaymentEvent extends PaymentEvent {
  final int amount;
  const InitiatePaymentEvent({required this.amount});


  // two instances of this class will be considered equal if their amount values are equal.
  // example:
  // InitiatePaymentEvent(amount: 100) == InitiatePaymentEvent(amount: 100) will return true.
  @override
  List<Object> get props => [amount];
}
