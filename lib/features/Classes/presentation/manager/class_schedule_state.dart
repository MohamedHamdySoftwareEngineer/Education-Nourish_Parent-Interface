import 'package:edunourish/features/Classes/data/models/classes_schedule_model.dart';

abstract class ClassScheduleState {}

class ClassScheduleInitial extends ClassScheduleState {}

class ClassScheduleLoading extends ClassScheduleState {}

class ClassScheduleLoaded extends ClassScheduleState {
  final List<ClassScheduleModel> schedule;

  ClassScheduleLoaded(this.schedule);
}

class ClassScheduleError extends ClassScheduleState {
  final String errorMessage;

  ClassScheduleError(this.errorMessage);
}
