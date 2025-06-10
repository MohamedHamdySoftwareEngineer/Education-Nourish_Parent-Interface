import 'package:equatable/equatable.dart';

abstract class BusEvent extends Equatable {
  const BusEvent();
}

class FetchBusById extends BusEvent {
  final int id;

  const FetchBusById({required this.id});

  @override
  List<Object> get props => [];
}
