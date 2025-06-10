import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Grade/data/models/grade_model.dart';
import 'package:edunourish/features/Grade/presentation/manager/grade_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/base_scaffold.dart';
import '../manager/grade_bloc.dart';
import '../manager/grade_state.dart';


class GradeScreen extends StatelessWidget {
  final int initialIndex;
  const GradeScreen({super.key, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GradeBloc>(
      create: (_) => GradeBloc(apiService: ApiService())..add(FetchGrades()),
      child: BlocBuilder<GradeBloc, GradeState>(
        builder: (context, state) {
          if (state is GradeLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is GradeError) {
            return Scaffold(
              body: Center(child: Text('Error: ${state.errorMessage}')),
            );
          }

          // state is GradeLoaded
          final grades = (state as GradeLoaded).grades;
          if (grades.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('No grades available.')),
            );
          }

          return BaseScaffold(
            initialIndex: initialIndex,
            appBartTitle: 'Grades',
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: grades.length,
              itemBuilder: (context, i) {
                final g = grades[i];
                // Map your GradeModel → your existing Grades class,
                // or adjust GradeCard to accept GradeModel directly.
                final cardData = GradeModel(
                  examId: g.subjectName ?? '—',
                  obtainedMarks: g.obtainedMarks,
                  grade: g.grade,
                  subjectName: g.subjectName,
                );
                return GradeCard(grade: cardData);
              },
            ),
          );
        },
      ),
    );
  }
}

class GradeCard extends StatelessWidget {
  final GradeModel grade;
  const GradeCard({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child:  Text(
                    grade.subjectName ?? '—',
                    style:const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green.shade50,
                  child: Text(
                    grade.grade,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(Icons.assignment, 'Assignment', grade.obtainedMarks),
                _buildStat(Icons.help_outline, 'Quiz', grade.obtainedMarks),
                _buildStat(Icons.school, 'Final', grade.obtainedMarks),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, int value) {
    final color = Colors.teal;
    return Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 4),
        Text('${value.toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
