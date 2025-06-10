import 'package:bloc/bloc.dart';

import 'package:edunourish/features/Exam/data/models/exam_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/utils/api_service.dart';


part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ApiService apiService;

  ExamBloc({required this.apiService}) : super(ExamInitial()) {
    on<FetchExam>(_onLoadExam);
  }

  Future<void> _onLoadExam(
      FetchExam event, Emitter<ExamState> emit) async {
    emit(ExamLoading());
    try {
      final exam = await apiService.fetchExam(endPoint: 'exams',id: event.id);
      emit(ExamLoaded(exam: exam));
    } catch (e) {
      emit(ExamError(message: e.toString()));
    }
  }
}
