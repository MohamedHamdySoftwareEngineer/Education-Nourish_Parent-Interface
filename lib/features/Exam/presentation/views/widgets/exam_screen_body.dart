import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/exam_model.dart';

class ExamScreenBody extends StatefulWidget {
  final List<ExamModel> exam;

  const ExamScreenBody({super.key, required this.exam});

  @override
  State<ExamScreenBody> createState() => _ExamScreenBodyState();
}

class _ExamScreenBodyState extends State<ExamScreenBody> {
  String? selectedType;
  String? selectedSubject;

  Color getExamTypeColor(String type) {
    switch (type) {
      case 'Midterm':
        return Colors.amber.shade700;
      case 'Final':
        return Colors.red.shade700;
      case 'Quiz':
        return Colors.green.shade700;
      default:
        return mainColor;
    }
  }

  IconData getSubjectIcon(String subject) {
    switch (subject) {
      case 'Math':
        return Icons.calculate;
      case 'Arabic':
        return Icons.language;
      case 'English':
        return Icons.book;
      case 'Science':
        return Icons.science;
      default:
        return Icons.subject;
    }
  }

  String _formatDate(DateTime dateTime) =>
      DateFormat('MMM d, yyyy').format(dateTime);

  String _formatTime(DateTime dateTime) =>
      DateFormat('h:mm a').format(dateTime);

  List<ExamModel> get filteredExams => widget.exam
      .where((exam) =>
          (selectedType == null || exam.type == selectedType) &&
          (selectedSubject == null || exam.subjectName == selectedSubject))
      .toList();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'Exam Screen',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              'Upcoming Exams',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          _buildFilterSection(),
          const SizedBox(height: 8),
          _buildExamList(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    final types = widget.exam.map((e) => e.type).toSet().toList();
    final subjects = widget.exam.map((e) => e.subjectName).toSet().toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              labelText: 'Exam Type',
              hintText: 'All',
              value: selectedType,
              items: types,
              onChanged: (value) => setState(() => selectedType = value),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDropdown(
              labelText: 'Exam Subject',
              hintText: 'All',
              value: selectedSubject,
              items: subjects,
              onChanged: (value) => setState(() => selectedSubject = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required String hintText,
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    final dropdownItems = [
      DropdownMenuItem<String>(
        value: null,
        child: Text(hintText, style: const TextStyle(color: Colors.black)),
      ),
      ...items.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          )),
    ];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: customBorder,
        enabledBorder: customBorder,
        focusedBorder: customBorder,
      ),
      value: value,
      items: dropdownItems,
      onChanged: onChanged,
      hint: Text(hintText),
      isExpanded: true,
    );
  }

  Widget _buildExamList() {
    final list = filteredExams;
    if (list.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No exams found',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final exam = list[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            getExamTypeColor(exam.type).withValues(alpha: 0.2),
                        radius: 24,
                        child: Icon(getSubjectIcon(exam.subjectName),
                            color: getExamTypeColor(exam.type), size: 26),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    exam.subjectName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  constraints: const BoxConstraints(
                                      minWidth: 80, maxWidth: 140),
                                  decoration: BoxDecoration(
                                      color: getExamTypeColor(exam.type),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(exam.type,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(_formatDate(exam.date),
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14)),
                                const SizedBox(width: 16),
                                Icon(Icons.access_time,
                                    size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(_formatTime(exam.date),
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
