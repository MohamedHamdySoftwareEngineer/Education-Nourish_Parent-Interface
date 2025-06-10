import 'package:equatable/equatable.dart';

abstract class GradeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchGrades extends GradeEvent {
  
  FetchGrades();
  @override 
  List<Object?> get props => [];
}
