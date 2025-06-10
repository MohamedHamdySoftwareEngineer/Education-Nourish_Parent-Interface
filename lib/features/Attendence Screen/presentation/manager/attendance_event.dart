abstract class AttendanceEvent {}

/// If studentId is null, the bloc will default to the first student.
class LoadAttendenceEvent extends AttendanceEvent {
  final String? studentId;
  LoadAttendenceEvent([this.studentId]);
}
