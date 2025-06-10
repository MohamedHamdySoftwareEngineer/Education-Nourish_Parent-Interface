import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/api_service.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ApiService apiService;
  PaymentBloc({required this.apiService}) : super(PaymentInitial()) {
    on<InitiatePaymentEvent>(_onInitiatePayment);
  }

  Future<void> _onInitiatePayment(
    InitiatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      final redirectUrl = await apiService.initiatePayment(
          amount: event.amount,
          endPoint: 'payments/create-checkout-session/21120');
      emit(PaymentSuccess(redirectUrl: redirectUrl));
    } catch (e) {
      emit(PaymentFailure(errorMessage: e.toString()));
    }
  }
}
