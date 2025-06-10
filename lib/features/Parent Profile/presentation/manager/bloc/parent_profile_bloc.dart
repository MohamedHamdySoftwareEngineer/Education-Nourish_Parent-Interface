import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Bus%20Screen/bloc/bus_bloc.dart';
import 'package:edunourish/features/Bus%20Screen/bloc/bus_event.dart';
import 'package:edunourish/features/Bus%20Screen/data/models/bus_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/Profile.dart';

part 'parent_profile_event.dart';
part 'parent_profile_state.dart';

class ParentProfileBloc extends Bloc<ParentProfileEvent, ParentProfileState> {
  final ApiService apiService;

  ParentProfileBloc({required this.apiService})
      : super(ParentProfileInitial()) {
    on<FetchParentProfile>(_onFetchParentProfile);
  }

  Future<void> _onFetchParentProfile(
    FetchParentProfile event,
    Emitter<ParentProfileState> emit,
  ) async {
    emit(ParentProfileLoading());
    try {
      // 1️⃣ Read the saved JWT
      final prefs = await SharedPreferences.getInstance(); // added
      final token = prefs.getString('auth_token') ?? '';
      final parentId = prefs.getString('roleId') ?? '';
      // added

      // 2️⃣ Fetch the single-parent record under /api/parents
      final parentProfile = await apiService.fetchParentProfile(
        endPoint: 'parents',
        token: token,
        id: parentId.toString(), // added
      );

      emit(ParentProfileLoaded(parentProfile));
    } catch (e) {
      emit(ParentProfileError(e.toString()));
    }
  }
}
