// lib/bloc/bus_state.dart
import 'package:equatable/equatable.dart';
import '../data/models/bus_model.dart';

abstract class BusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusInitial extends BusState {}

class BusLoading extends BusState {}

class BusLoaded extends BusState {
  final Bus bus;
  BusLoaded(this.bus);

  @override
  List<Object?> get props => [bus];
}

class BusError extends BusState {
  final String message;
  BusError(this.message);

  @override
  List<Object?> get props => [message];
}
