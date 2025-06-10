// exam_event.dart
part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();
  @override List<Object?> get props => [];
}

class FetchExam extends ExamEvent {
  final String id;
  const FetchExam(this.id);

  @override List<Object?> get props => [id];
}
