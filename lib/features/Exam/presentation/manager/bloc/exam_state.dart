// exam_state.dart
part of 'exam_bloc.dart';

abstract class ExamState extends Equatable {
  const ExamState();
  @override
  List<Object?> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final ExamModel exam;
  const ExamLoaded({required this.exam});
  @override
  List<Object?> get props => [exam];
}

class ExamError extends ExamState {
  final String message;
  const ExamError({required this.message});
  @override
  List<Object?> get props => [message];
}
