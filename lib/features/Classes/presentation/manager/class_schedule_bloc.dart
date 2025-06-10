import 'package:edunourish/core/utils/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'class_schedule_event.dart';
import 'class_schedule_state.dart';

class ClassScheduleBloc extends Bloc<ClassScheduleEvent, ClassScheduleState> {
  final ApiService apiService;

  ClassScheduleBloc({required this.apiService})
      : super(ClassScheduleInitial()) {
    on<FetchClassSchedule>(_onFetchClassSchedule);
  }

  Future<void> _onFetchClassSchedule(
    FetchClassSchedule event,
    Emitter<ClassScheduleState> emit,
  ) async {
    emit(ClassScheduleLoading());

    try {
      final schedule =
          await apiService.fetchClassSchedule(endPoint: 'timetables');
      emit(ClassScheduleLoaded(schedule));
    } catch (e) {
      emit(ClassScheduleError(e.toString()));
    }
  }
}
