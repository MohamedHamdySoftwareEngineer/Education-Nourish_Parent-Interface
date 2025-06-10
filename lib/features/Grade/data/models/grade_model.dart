class GradeModel {
  final String examId;
  final int obtainedMarks;
  final String grade;
  String? subjectName; // to be filled later

  GradeModel({
    required this.examId,
    required this.obtainedMarks,
    required this.grade,
    this.subjectName,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
    examId: json['examId'] as String,
    obtainedMarks: int.parse(json['obtainedMarks'] as String),
    grade: json['grade'] as String,
  );
}
