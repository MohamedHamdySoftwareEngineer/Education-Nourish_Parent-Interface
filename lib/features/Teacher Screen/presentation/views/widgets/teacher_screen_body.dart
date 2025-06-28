
import 'package:edunourish/core/utils/assets.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Teacher%20Screen/data/models/teacher_model.dart';

import 'package:flutter/material.dart';


class TeacherScreenBody extends StatelessWidget {
  final List<TeacherData> teachers;
  
  const TeacherScreenBody({super.key,required this.teachers});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: "Teachers",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  return TeacherCard(teacher: teachers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final TeacherData teacher;

  const TeacherCard({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Teacher Image on the left
            CircleAvatar(
              radius: 35,
              child: ClipOval(
                child: Image.asset(
                  teacherImage,
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.grey.shade700,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Teacher Info on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // Teacher Name
                  Text(
                    teacher.username,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Teacher Email
                
                  Text(
                    teacher.email,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Subject Badge
                  Text(
                    '${teacher.subject.name} teacher',
                   
                    style:  TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}