import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/api_service.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final ApiService apiService;
  AttendanceBloc(this.apiService) : super(AttendanceInitial()) {
    on<LoadAttendenceEvent>(_onLoadAttendance);
  }

  Future<void> _onLoadAttendance(
    LoadAttendenceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    try {
      final prefs    = await SharedPreferences.getInstance();
      final token    = prefs.getString('auth_token') ?? '';
      final parentId = prefs.getString('roleId')    ?? '';

      final response = await apiService.fetchAttendanceData(
        endPoint: 'parents',
        token: token,
        parentId: parentId,
      );

      final studentId = event.studentId ?? response.students.first.id;
      final student   = response.students.firstWhere(
        (s) => s.id == studentId,
        orElse: () => throw Exception('Student not found'),
      );

      emit(AttendanceLoaded(student.attendances));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}
