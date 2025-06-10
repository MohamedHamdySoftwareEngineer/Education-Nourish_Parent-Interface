import 'package:edunourish/features/Grade/data/models/grade_model.dart';
import 'package:equatable/equatable.dart';

abstract class GradeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GradeLoading extends GradeState {}

class GradeLoaded extends GradeState {
  final List<GradeModel> grades;
  GradeLoaded({required this.grades});
  @override
  List<Object?> get props => [grades];
}
class GradeError extends GradeState {
  final String errorMessage;
  GradeError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
