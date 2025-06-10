import '../../data/models/attendence_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecord> records;

  AttendanceLoaded(this.records);
}

class AttendanceError extends AttendanceState {
  final String errorMessage;

  AttendanceError(this.errorMessage);
}
