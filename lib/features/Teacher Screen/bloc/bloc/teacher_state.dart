import 'package:equatable/equatable.dart';
import '../../data/models/teacher_model.dart';  // adjust path if needed

/// Define states for TeacherBloc
abstract class TeacherState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class TeacherInitial extends TeacherState {}

/// While the teacher data is loading
class TeacherLoading extends TeacherState {}

/// When teacher data is successfully fetched
class TeacherLoaded extends TeacherState {
  final TeacherData teacher;

  TeacherLoaded(this.teacher);

  @override
  List<Object?> get props => [teacher];
}

/// When an error occurs
class TeacherError extends TeacherState {
  final String message;

  TeacherError(this.message);

  @override
  List<Object?> get props => [message];
}

