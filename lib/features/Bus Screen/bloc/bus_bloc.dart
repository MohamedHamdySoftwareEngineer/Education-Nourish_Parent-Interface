// lib/bloc/bus_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/api_service.dart';

import 'bus_event.dart';
import 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  final ApiService apiService;

  BusBloc({required this.apiService}) : super(BusInitial()) {
    on<FetchBusById>(_onFetchBusById);
  }

  Future<void> _onFetchBusById(FetchBusById event, Emitter<BusState> emit) async {
    emit(BusLoading());
    try {
      final bus = await apiService.fetchBusById(endPoint: 'buses',id:event.id);
      emit(BusLoaded(bus));
    } catch (e) {
      emit(BusError(e.toString()));
    }
  }
}
