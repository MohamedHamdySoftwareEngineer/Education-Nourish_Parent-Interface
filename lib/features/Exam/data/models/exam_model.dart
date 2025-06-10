class ExamModel {
  final String id;
  final String subjectName;
  final int duration;
  final int totalMarks;
  final DateTime date;
  final String status;
  final String type;

  ExamModel({
    required this.id,
    required this.subjectName,
    required this.duration,
    required this.totalMarks,
    required this.date,
    required this.status,
    required this.type,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json['id'] as String,
        subjectName: json['subjectName'] as String,
        duration: json['duration'] as int,
        totalMarks: json['totalMarks'] as int,
        date: DateTime.parse(json['date'] as String),
        status: json['status'] as String,
        type: json['Type'] as String,
      );
}
