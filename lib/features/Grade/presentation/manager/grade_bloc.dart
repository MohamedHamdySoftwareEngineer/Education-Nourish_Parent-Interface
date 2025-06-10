import 'package:edunourish/core/utils/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'grade_event.dart';
import 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final ApiService apiService;
  GradeBloc({required this.apiService}) : super(GradeLoading()) {
    on<FetchGrades>(_onFetchGrades);
  }

  Future<void> _onFetchGrades(
    FetchGrades event,
    Emitter<GradeState> emit,
  ) async {
    emit(GradeLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      final parentId = prefs.getString('roleId') ?? '';

      final gradeResponse = await apiService.fetchGrades(
          endPoint: 'parents', token: token, parentId: parentId);

      for (var grade in gradeResponse) {
        final exam =
            await apiService.fetchExam(endPoint: 'exams', id: grade.examId);
        grade.subjectName = exam.subjectName;
      }

      emit(GradeLoaded(grades: gradeResponse));
    } catch (e) {
      emit(GradeError(errorMessage: 'Faild to load grades:$e'));
    }
  }
}
