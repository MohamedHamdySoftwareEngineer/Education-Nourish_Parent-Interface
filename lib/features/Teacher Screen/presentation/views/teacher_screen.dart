
import 'package:edunourish/features/Teacher%20Screen/bloc/bloc/teacher_bloc.dart';
import 'package:edunourish/features/Teacher%20Screen/bloc/bloc/teacher_state.dart';
import 'package:edunourish/features/Teacher%20Screen/presentation/views/widgets/teacher_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api_service.dart';
import '../../bloc/bloc/teacher_event.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TeacherBloc(apiService: ApiService())..add(LoadTeacherEvent('22')),
      child: Scaffold(
        body: BlocSelector<TeacherBloc, TeacherState, TeacherState>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            if (state is TeacherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TeacherLoaded) {
              // pass the loaded exam into your body widget
              return TeacherScreenBody(teachers: [state.teacher]);
            } else if (state is TeacherError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            // fallback for any other/unexpected states
            return const Center(child: Text('Try again later!'));
          },
        ),
      ),
    );
  }
}
