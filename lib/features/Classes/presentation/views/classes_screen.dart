// lib/features/Parent/features/Classes/presentation/views/classes_screen_body.dart

import 'package:edunourish/core/widgets/base_scaffold.dart';

import 'package:edunourish/features/Classes/data/models/classes_schedule_model.dart';
import 'package:edunourish/core/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/class_schedule_bloc.dart';
import '../manager/class_schedule_event.dart';
import '../manager/class_schedule_state.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  late final ClassScheduleBloc _bloc;

  static const _weekOrder = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  @override
  void initState() {
    super.initState();
    _bloc = ClassScheduleBloc(apiService: ApiService())..add(FetchClassSchedule());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: "Classes",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const SearchBar(),
              const SizedBox(height: 30),
              const Text(
                "class schedule",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ClassScheduleBloc, ClassScheduleState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is ClassScheduleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ClassScheduleError) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  }
                  if (state is ClassScheduleLoaded) {
                    return _buildScheduleTable(state.schedule);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTable(List<ClassScheduleModel> raw) {
    if (raw.isEmpty) return const Text("No schedule.");

    // 1. Collect unique time-ranges:
    final times = raw.first.times;
    final timeRanges = <String>[];
    for (var i = 0; i + 1 < times.length; i++) {
      timeRanges.add('${times[i]} - ${times[i + 1]}');
    }

    // 2. Map day → model, pick first if duplicates
    final map = <String, ClassScheduleModel>{};
    for (var m in raw) {
      final key = m.day.toLowerCase().trim();
      map.putIfAbsent(key, () => m);
    }

    // 3. Build list of days present, ordered by week
    final days = map.keys
        .toList()
        .where((d) => _weekOrder.contains(d))
        .toList()
      ..sort((a, b) => _weekOrder.indexOf(a).compareTo(_weekOrder.indexOf(b)));

    // 4. Columns: Time + 3-letter day headers
    final columns = <DataColumn>[
      const DataColumn(label: Text("Time", style: TextStyle(fontSize: 16))),
      ...days.map((d) {
        return DataColumn(
          label: Text(d.substring(0, 3).toUpperCase(), style: const TextStyle(fontSize: 16)),
        );
      }),
    ];

    // 5. Rows: for each range, one DataRow
    final rows = timeRanges.map((range) {
      final cells = <DataCell>[DataCell(Text(range, style: const TextStyle(fontSize: 14)))];
      for (var d in days) {
        final model = map[d]!;
        // figure subject slot index: index of this range
        final idx = timeRanges.indexOf(range);
        final subject = idx < model.subjects.length ? model.subjects[idx] : '';
        cells.add(DataCell(Text(subject, style: const TextStyle(fontSize: 14))));
      }
      return DataRow(cells: cells);
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columnSpacing: 16.0,
          horizontalMargin: 15.0,
          headingRowHeight: 40.0,
          dataRowMaxHeight: 40.0,
          dataRowMinHeight: 40.0,
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }


}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: const Row(
        children: [
          Icon(Icons.menu, color: Colors.black),
          SizedBox(width: 16),
          Expanded(child: TextField(decoration: InputDecoration(hintText: "Search classes", border: InputBorder.none))),
          Icon(Icons.search, color: Colors.black),
        ],
      ),
    );
  }
}
