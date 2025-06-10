import 'package:equatable/equatable.dart';

/// Define events for TeacherBloc
abstract class TeacherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Trigger loading a specific teacher by ID
class LoadTeacherEvent extends TeacherEvent {
  final String id;
  LoadTeacherEvent(this.id);

  @override
  List<Object?> get props => [id];
}