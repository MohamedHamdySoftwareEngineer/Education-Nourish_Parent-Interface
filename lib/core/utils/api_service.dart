
import 'package:dio/dio.dart';
import 'package:edunourish/features/Exam/data/models/exam_model.dart';
import 'package:edunourish/features/Grade/data/models/grade_model.dart';
import '../../features/Attendence Screen/data/models/attendence_model.dart';
import '../../features/Bus Screen/data/models/bus_model.dart';
import '../../features/Classes/data/models/classes_schedule_model.dart';
import '../../features/Parent Profile/data/models/Profile.dart';
import '../../features/Restaurant Screen/data/models/menu_item_model.dart';
import '../../features/Teacher Screen/data/models/teacher_model.dart';
// adjust path as needed

class ApiService {
  final _baseUrl = 'http://54.242.19.19:3000/api/';
  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches a single Parent Profile, using the saved JWT for auth.
  Future<Profile> fetchParentProfile({
    required String endPoint,
    required String token,
    required String id, // added
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}), //added
    );

    final data = response.data;
    if (data is List) {
      // old behavior, if your backend ever returns an array
      if (data.isEmpty) throw Exception('No users found');
      return Profile.fromJson(data.first as Map<String, dynamic>);
    } else if (data is Map<String, dynamic>) {
      // Common case: a single object
      // If your API wraps it in { "data": { … } }, uncomment the next two lines:
      // final wrapper = data['data'] as Map<String, dynamic>?;
      // return Profile.fromJson(wrapper ?? data);

      return Profile.fromJson(data);
    } else {
      throw Exception('Unexpected response format: ${data.runtimeType}');
    }
  }

  /// Fetches a single Bus by ID from your API
  Future<Bus> fetchBusById({required String endPoint, required int id}) async {
    final response = await _dio.get('$_baseUrl$endPoint/$id');
    return Bus.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ExamModel> fetchExam(
      {required String endPoint, required String id}) async {
    final response = await _dio.get('$_baseUrl$endPoint/$id');
    return ExamModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetches a Teacher by ID and wraps it in your ApiResponse model
  Future<ApiResponse> fetchTeacher({
    required String endPoint,
    required String id,
  }) async {
    final response = await _dio.get('$_baseUrl$endPoint/$id');
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<String> initiatePayment(
      {required int amount, required String endPoint}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl$endPoint',
        data: {'amount': amount},
      );

      if (response.statusCode == 200) {
        final redirectUrl = response.data['url'] as String?;

        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          return redirectUrl;
        } else {
          throw Exception('Invalid response format: Missing URL');
        }
      } else {
        throw Exception(
            'Payment failed with status code:${response.statusCode} - ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Payment error: ${e.toString()}');
    }
  }

  Future<List<MenuItem>> fetchMenuItems({required String endPoint}) async {
    final response = await _dio.get('$_baseUrl$endPoint');
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data
          .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to load menu items: ${response.statusCode} - ${response.data}');
    }
  }

  Future<List<ClassScheduleModel>> fetchClasses(
      {required String endPoint}) async {
    try {
      final response = await _dio.get('$_baseUrl$endPoint');
      final List data = response.data as List;
      return data.map((e) => ClassScheduleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load classes: ${e.toString()}');
    }
  }

  Future<ParentAttendanceResponse> fetchAttendanceData({
    required String endPoint,
    required String token,
    required String parentId,
  }) async {
    final response = await _dio.get(
      '$_baseUrl$endPoint/$parentId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.statusCode == 200) {
      return ParentAttendanceResponse.fromJson(response.data);
    }
    throw Exception(
        'Failed to load attendance: ${response.statusCode} ${response.statusMessage}');
  }

  Future<List<ClassScheduleModel>> fetchClassSchedule({
    required String endPoint,
  }) async {
    final response = await _dio.get('$_baseUrl$endPoint');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) =>
              ClassScheduleModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to load schedule:${response.statusCode}-${response.statusMessage}');
    }
  }


  Future<List<GradeModel>> fetchGrades({
  required String endPoint,
  required String token,
  required String parentId,
}) async {
  final response = await _dio.get<Map<String, dynamic>>(
    '$_baseUrl$endPoint/$parentId',
    options: Options(headers: {'Authorization': 'Bearer $token'}),
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load grades: ${response.statusCode} – ${response.statusMessage}',
    );
  }

  // 1) Get the raw “Students” list (or empty if missing)
  final students = response.data?['Students'] as List<dynamic>? ?? [];

  // 2) For each student, pull out their “Grads” and map to GradeModel
  return students
      .expand((stu) {
        final grads = (stu as Map<String, dynamic>)['Grads'] as List<dynamic>? ?? [];
        return grads;
      })
      .cast<Map<String, dynamic>>()                // each item is JSON map
      .map((json) => GradeModel.fromJson(json))    // to your model
      .toList();
}

}
