import 'dart:convert';

// Helper function to decode the JSON string and create the ApiResponse object
ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

// Helper function to encode the ApiResponse object back to a JSON string
String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
    final bool success;
    final TeacherData data;

    ApiResponse({
        required this.success,
        required this.data,
    });

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        // Create TeacherData object from the nested 'data' map
        data: TeacherData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(), // Convert TeacherData object back to map
    };
}

class TeacherData {
    final String teacherId; // Renamed from teacherID for Dart convention
    final String username;
    final String email;
    final String password; // Note: Storing passwords like this is insecure
    final String phoneNumber;
    final String address;
    final int age;
    final String gender;
    final int salary;
    final String subjectId; // Renamed from SubjectID for Dart convention
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<dynamic> advice; // Use List<String> or a specific Advice class if structure is known
    final List<dynamic> attendances; // Use List<Attendance> or similar if structure is known
    final Subject subject; // Renamed from Subject for Dart convention

    TeacherData({
        required this.teacherId,
        required this.username,
        required this.email,
        required this.password,
        required this.phoneNumber,
        required this.address,
        required this.age,
        required this.gender,
        required this.salary,
        required this.subjectId,
        required this.createdAt,
        required this.updatedAt,
        required this.advice,
        required this.attendances,
        required this.subject,
    });

    factory TeacherData.fromJson(Map<String, dynamic> json) => TeacherData(
        teacherId: json["teacherID"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        age: json["age"],
        gender: json["gender"],
        salary: json["salary"],
        subjectId: json["SubjectID"],
        // Parse date strings into DateTime objects
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        // Handle lists - assumes they contain simple types or need further parsing if complex
        advice: List<dynamic>.from(json["Advice"].map((x) => x)),
        attendances: List<dynamic>.from(json["Attendances"].map((x) => x)),
        // Create Subject object from the nested 'Subject' map
        subject: Subject.fromJson(json["Subject"]),
    );

    Map<String, dynamic> toJson() => {
        "teacherID": teacherId,
        "username": username,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "age": age,
        "gender": gender,
        "salary": salary,
        "SubjectID": subjectId,
        // Convert DateTime objects back to ISO 8601 strings
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Advice": List<dynamic>.from(advice.map((x) => x)),
        "Attendances": List<dynamic>.from(attendances.map((x) => x)),
        "Subject": subject.toJson(), // Convert Subject object back to map
    };
}

class Subject {
    final String subjectId; // Renamed from SubjectID for Dart convention
    final String name;
    final String code;
    final String category;
    final String gradeLevel;
    final String semester;
    final String description;
    final String studentId; // Assuming this is correct, even though it's under Subject
    final DateTime createdAt;
    final DateTime updatedAt;

    Subject({
        required this.subjectId,
        required this.name,
        required this.code,
        required this.category,
        required this.gradeLevel,
        required this.semester,
        required this.description,
        required this.studentId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["SubjectID"],
        name: json["name"],
        code: json["code"],
        category: json["category"],
        gradeLevel: json["gradeLevel"],
        semester: json["semester"],
        description: json["description"],
        studentId: json["studentId"],
        // Parse date strings into DateTime objects
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "SubjectID": subjectId,
        "name": name,
        "code": code,
        "category": category,
        "gradeLevel": gradeLevel,
        "semester": semester,
        "description": description,
        "studentId": studentId,
        // Convert DateTime objects back to ISO 8601 strings
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

