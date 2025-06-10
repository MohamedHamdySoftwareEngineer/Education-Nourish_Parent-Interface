import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Payment%20Screen/presentation/manager/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/payment_screen_body.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => PaymentBloc(apiService: ApiService()),
        child: const PaymentScreenBody(),
      ),
    );
  }
}
