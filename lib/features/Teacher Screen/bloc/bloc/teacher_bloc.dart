import 'package:bloc/bloc.dart';

import '../../../../core/utils/api_service.dart';
import 'teacher_event.dart';
import 'teacher_state.dart';

/// BLoC that handles loading teacher data via ApiService
class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final ApiService apiService;

  TeacherBloc({required this.apiService}) : super(TeacherInitial()) {
    on<LoadTeacherEvent>(_onLoadTeacher);
  }

  Future<void> _onLoadTeacher(
      LoadTeacherEvent event,
      Emitter<TeacherState> emit,
  ) async {
    emit(TeacherLoading());
    try {
      // Call your ApiService; endpoint 'teachers' assumed, change if needed
      final resp = await apiService.fetchTeacher(
        endPoint: 'teachers',
        id: event.id,
      );
      if (resp.success) {
        emit(TeacherLoaded(resp.data));
      } else {
        emit(TeacherError('API returned success=false'));
      }
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }
}
