
import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Exam/presentation/manager/bloc/exam_bloc.dart';
import 'package:edunourish/features/Exam/presentation/views/widgets/exam_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExamBloc(apiService: ApiService())..add( const FetchExam('EX1')),
      child: Scaffold(
        body: BlocSelector<ExamBloc, ExamState, ExamState>(
          selector: (state) => state,
          builder: (context, state) {
            if (state is ExamLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExamLoaded) {
              // pass the loaded exam into your body widget
              return ExamScreenBody(exam: [state.exam]);
            } else if (state is ExamError) {
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
