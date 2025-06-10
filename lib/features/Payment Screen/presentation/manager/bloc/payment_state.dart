import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentSuccess extends PaymentState {
  final String redirectUrl;
  const PaymentSuccess({required this.redirectUrl});

  @override
  List<Object> get props => [redirectUrl];
}

class PaymentFailure extends PaymentState {
  final String errorMessage;
  const PaymentFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
