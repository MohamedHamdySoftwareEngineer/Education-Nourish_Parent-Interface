class ParentAttendanceResponse {
  final String id;
  final List<Student> students;

  ParentAttendanceResponse({
    required this.id,
    required this.students,
  });

  factory ParentAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return ParentAttendanceResponse(
      id: json['id'],
      students: (json['Students'] as List)
          .map((s) => Student.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Student {
  final String id;
  final String userName;
  final List<AttendanceRecord> attendances;

  Student({
    required this.id,
    required this.userName,
    required this.attendances,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      userName: json['userName'],
      attendances: (json['Attendances'] as List)
          .map((a) => AttendanceRecord.fromJson(a as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AttendanceRecord {
  final String id;
  final DateTime date;
  final bool isPresent;
  final String status;
  final String remarks;
  final String teacherId;

  AttendanceRecord({
    required this.id,
    required this.date,
    required this.isPresent,
    required this.remarks,
    required this.teacherId,
    required this.status,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      date: DateTime.parse(json['date']),
      isPresent: json['status'] == 'present',
      status: json['status'] as String,
      remarks: json['remarks'] as String,
      teacherId: json['teacherID'] as String,
    );
  }
}
