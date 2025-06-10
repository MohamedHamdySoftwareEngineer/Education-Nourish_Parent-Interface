import 'package:flutter/material.dart';
import 'package:edunourish/features/Attendence%20Screen/presentation/views/attendence_screen.dart';
import 'package:edunourish/features/Bus%20Screen/presentation/views/bus_screen.dart';
import 'package:edunourish/features/Classes/presentation/views/classes_screen.dart';
import 'package:edunourish/features/Exam/presentation/views/exam_screen.dart';
import 'package:edunourish/features/Grade/presentation/views/grade_screen.dart';
import 'package:edunourish/features/List%20Screen/presentation/views/list_screen.dart';
import 'package:edunourish/features/My%20Child%20Screen/presentation/views/my_child_screen.dart';
import 'package:edunourish/features/Notifications%20Screen/presentation/presentation/views/notifications_screen.dart';
import 'package:edunourish/features/Parent%20Home/presentation/views/parent_home.dart';
import 'package:edunourish/features/Parent%20Profile/presentation/views/parent_profile.dart';
import 'package:edunourish/features/Payment%20Screen/presentation/views/payment.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/views/restaurant_screen.dart';
import 'package:edunourish/features/Settings%20Screen/presentation/views/settings_screen.dart';
import 'package:edunourish/features/Teacher%20Screen/presentation/views/teacher_screen.dart';

abstract class AppRouter {
  
  static Future<T?> toParentHome<T>(BuildContext c, {int initalIndex = 2}) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => ParentHome(initialIndex: initalIndex))
      );

  static Future<T?> toPaymentScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const PaymentScreen())
      );

  static Future<T?> toBusScreen<T>(BuildContext c, {int initialIndex = 1}) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => BusScreen(initialIndex: initialIndex))
      );

  static Future<T?> toSettingsScreen<T>(BuildContext c, {int initialIndex = 4}) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => SettingsScreen(initialIndex: initialIndex))
      );

  static Future<T?> toParentProfile<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const ParentProfile())
      );

  static Future<T?> toMyChildScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const MyChildScreen())
      );

  static Future<T?> toClassesScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const ClassesScreen())
      );

  static Future<T?> toAttendenceScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const AttendanceScreen())
      );

  static Future<T?> toExamScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const ExamScreen())
      );

  static Future<T?> toGradeScreen<T>(BuildContext c, {int initialIndex = 3}) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => GradeScreen(initialIndex: initialIndex))
      );

  static Future<T?> toTeacherScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const TeacherScreen())
      );

  static Future<T?> toListScreen<T>(BuildContext c, {int initialIndex = 0}) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => ListScreen(initialIndex: initialIndex))
      );

  static Future<T?> toNotifications<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const NotificationsScreen())
      );

  static Future<T?> toRestaurantScreen<T>(BuildContext c) =>
      Navigator.push<T>(
        c, 
        MaterialPageRoute(builder: (_) => const RestaurantScreen())
      );

  static void toBack<T>(BuildContext c, [T? result]) =>
      Navigator.pop<T>(c, result);
}