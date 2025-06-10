class ClassScheduleModel {
  final String id;
  final String day;
  final List<String> subjects;
  final List<String> times;
  final String classId;

  ClassScheduleModel({
    required this.id,
    required this.day,
    required this.subjects,
    required this.times,
    required this.classId,
  });

  factory ClassScheduleModel.fromJson(Map<String, dynamic> json) {
    final rawDay = json['day']?.toString().trim() ?? '';
    final rawSubjects = (json['subject']?.toString() ?? '').split('/');
    final rawTimes = (json['time']?.toString() ?? '').split('/');

    return ClassScheduleModel(
      id: json['id']?.toString() ?? '',
      day: rawDay,
      subjects: rawSubjects.map((s) => s.trim()).toList(),
      times: rawTimes.map((t) => t.trim()).toList(),
      classId: json['classId']?.toString() ?? '',
    );
  }
}