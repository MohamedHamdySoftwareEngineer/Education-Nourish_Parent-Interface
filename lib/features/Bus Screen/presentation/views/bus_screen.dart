import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Bus%20Screen/bloc/bus_bloc.dart';
import 'package:edunourish/features/Bus%20Screen/presentation/views/widgets/bus_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bus_event.dart';

class BusScreen extends StatelessWidget {
  final int initialIndex;
  const BusScreen({super.key, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusBloc(apiService: ApiService())..add(const FetchBusById(id: 31)),
      child:  Scaffold(
        body: BusScreenBody(initialIndex: initialIndex,),
      ),
    );
  }
}
