import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/api_service.dart';
import '../manager/attendance_bloc.dart';
import '../manager/attendance_event.dart';
import 'widgets/attendence_screen_body.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendanceBloc>(
      create: (_) => AttendanceBloc(ApiService())
        ..add(LoadAttendenceEvent()),
      child: const AttendanceScreenBody(),
    );
  }
}