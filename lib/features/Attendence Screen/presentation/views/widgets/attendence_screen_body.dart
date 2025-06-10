// attendance_screen_body.dart
import 'package:edunourish/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/base_scaffold.dart';
import '../../../data/models/attendence_model.dart';
import '../../manager/attendance_bloc.dart';
import '../../manager/attendance_state.dart';



class AttendanceScreenBody extends StatefulWidget {
  const AttendanceScreenBody({super.key});

  @override
  _AttendanceScreenBodyState createState() => _AttendanceScreenBodyState();
}

class _AttendanceScreenBodyState extends State<AttendanceScreenBody> {
  int currentMonth = DateTime.now().month;
  int currentYear  = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'Attendance',
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (ctx, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AttendanceError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          if (state is AttendanceLoaded) {
            final all = state.records;
            final monthRecords = all.where((r) =>
              r.date.month == currentMonth && r.date.year == currentYear
            ).toList();

            final total   = monthRecords.length;
            final present = monthRecords.where((r) => r.isPresent).length;
            final absent  = total - present;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildMonthSelector(),
                  const SizedBox(height: 16),
                  _CalendarGrid(
                    records: monthRecords,
                    month: currentMonth,
                    year: currentYear,
                  ),
                  const SizedBox(height: 16),
                  _buildLegend(),
                  const SizedBox(height: 16),
                  _buildStats(total, present, absent),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Month selector row
  Widget _buildMonthSelector() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 2.5),
              decoration: BoxDecoration(
                color: ourMainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _prevMonth,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${_monthName(currentMonth)} $currentYear',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),
          ],
        );
  }

  void _prevMonth() {
    setState(() {
      if (currentMonth == 1) {
        currentMonth = 12;
        currentYear--;
      } else {
        currentMonth--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (currentMonth == 12) {
        currentMonth = 1;
        currentYear++;
      } else {
        currentMonth++;
      }
    });
  }

  static String _monthName(int m) {
    const names = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return names[m - 1];
  }

  // Legend mapping
  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _legendTile(Colors.teal, 'Present'),
          _legendTile(Colors.red,  'Absent'),
          _legendTile(Colors.blue, 'Today'),
        ],
      ),
    );
  }

  Widget _legendTile(Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  // Stats cards
  Widget _buildStats(int total, int present, int absent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _statCard('Total School Days', total, Colors.teal),
          const SizedBox(height: 8),
          _statCard('Total Present', present, Colors.green),
          const SizedBox(height: 8),
          _statCard('Total Absent',   absent,  Colors.red),
        ],
      ),
    );
  }

  Widget _statCard(String title, int count, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$title: $count',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

// Calendar grid
class _CalendarGrid extends StatelessWidget {
  final List<AttendanceRecord> records;
  final int month;
  final int year;

  const _CalendarGrid({
    required this.records,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    final first = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = first.weekday % 7;

    List<Widget> tiles = [];

    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    for (final d in days) {
      tiles.add(Center(
          child: Text(d, style: const TextStyle(fontWeight: FontWeight.bold))));
    }

    for (int i = 0; i < startWeekday; i++) {
      tiles.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final attendance = records.firstWhere(
        (r) =>
            r.date.day == day && r.date.month == month && r.date.year == year,
        orElse: () => AttendanceRecord(date: date, isPresent: false, id: '', remarks: '', teacherId: '',status: 'none'),
      );

      Color bg;
      Color textColor = Colors.black;

      switch (attendance.status) {
        case 'present':
          bg = Colors.teal;
          textColor = Colors.white;
          break;
        case 'absent':
          bg = Colors.red;
          textColor = Colors.white;
          break;
        case 'holiday':
          bg = Colors.grey;
          textColor = Colors.white;
          break;
        default:
          bg = Colors.transparent;
          textColor = Colors.black;
      }

      // Highlight today if no attendance
      final isToday = date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year;

      if (isToday && attendance.status == 'none') {
        bg = Colors.blue;
        textColor = Colors.white;
      }

      tiles.add(
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(2), // slight spacing
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: Colors.black12, width: 1), // border added
            borderRadius: BorderRadius.circular(4), // less rounding
          ),
          child: Text(
            day.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ourMainColor,width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GridView.count(
        crossAxisCount: 7,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: tiles,
      ),
    );
  }
}