import 'package:edunourish/core/utils/app_router.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/core/widgets/container_tile.dart';
import 'package:edunourish/features/Attendence%20Screen/presentation/views/attendence_screen.dart';
import 'package:edunourish/features/Classes/presentation/views/classes_screen.dart';
import 'package:edunourish/features/Exam/presentation/views/exam_screen.dart';
import 'package:edunourish/features/Parent%20Profile/presentation/views/parent_profile.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/views/restaurant_screen.dart';
import 'package:flutter/material.dart';

class ListScreenBody extends StatelessWidget {
  final int initialIndex;
  const ListScreenBody({super.key,required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      initialIndex: initialIndex,
      appBartTitle: 'List Screen',
      child: Container(
        color: ourBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ListView(
                  children: [
                    _buildSettingsCategory(
                        title: 'Academic', icon: Icons.school_outlined),
                    ContainerTile(
                      icon: Icons.people_outline,
                      title: 'My Teachers',
                      onTap: () {
                        AppRouter.toTeacherScreen(context);
                      },
                    ),
                    ContainerTile(
                      icon: Icons.table_view_rounded,
                      title: 'My Class Schedule',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClassesScreen(),
                          ),
                        );
                      },
                    ),
                    ContainerTile(
                      icon: Icons.book_outlined,
                      title: 'Exams',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExamScreen(),
                          ),
                        );
                      },
                    ),
                    ContainerTile(
                      icon: Icons.calendar_month_rounded,
                      title: 'Attendance',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AttendanceScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingsCategory(
                        title: 'Services', icon: Icons.room_service_outlined),
                    ContainerTile(
                      icon: Icons.fastfood_outlined,
                      title: 'Restaurant',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingsCategory(
                        title: 'Personal', icon: Icons.person_outline),
                    ContainerTile(
                      icon: Icons.person_outlined,
                      title: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ParentProfile(),
                          ),
                        );
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCategory(
      {required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
