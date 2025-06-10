
import 'package:intl/intl.dart';

class Bus {
  final int? id;
  final String? number;
  final String? driverName;
  final DateTime? arrivalTime;
  final DateTime? departureTime;

  Bus({
    required this.id,
    required this.number,
    required this.driverName,
    required this.arrivalTime,
    required this.departureTime,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: _parseInt(json['id']),
      number: _parseString(json['number']),
      driverName: _parseString(json['driverName']),
       arrivalTime: _parseDateTime(json['arrivalTime']),
      departureTime: _parseDateTime(json['departureTime']),
        // .toLocal(),
    );
  }

// Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0; // Fallback
  }

  // Helper method to safely parse strings
  static String _parseString(dynamic value) {
    if (value is String) return value;
    if (value is int || value is double) return value.toString();
    return ''; // Fallback
  }

static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // In your Bus model class
String get formattedArrivalTime {
  if (arrivalTime == null) return '';
  return DateFormat('h:mm a').format(arrivalTime!);
}

String get formattedDepartureTime {
  if (departureTime == null) return '';
  return DateFormat('h:mm a').format(departureTime!);
}
}
