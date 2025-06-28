import 'package:edunourish/core/utils/app_router.dart';
import 'package:edunourish/core/utils/assets.dart';
import 'package:edunourish/core/widgets/child_profile_card.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Parent%20Home/presentation/views/widgets/build_icon_card.dart';
import 'package:flutter/material.dart';


class MyChildScreenBody extends StatelessWidget {
  const MyChildScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'My Child',
        child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 35),
          
          const ChildProfileCard(),
         const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 36,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.all(20),
              children: [
                InkWell(
                  onTap: () {
                    AppRouter.toClassesScreen(context);
                  },
                  child: const BuildIconCard(label: 'Classes', imagePath: classesImage,imageSize: 72,),
                ),
                InkWell(
                  onTap: () {
                    AppRouter.toAttendenceScreen(context);
                  },
                  child: const BuildIconCard(label: 'Attendance', imagePath: attendanceImage,imageSize: 72,),
                ),
                InkWell(
                    onTap: () {
                      AppRouter.toRestaurantScreen(context);
                    },
                    child: const BuildIconCard(label: 'Food Place', imagePath: restaurantImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toGradeScreen(context,initialIndex: 3);
                    },
                    child: const BuildIconCard(label: 'Grade', imagePath: gradesImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toExamScreen(context);
                    },
                    child: const BuildIconCard(label: 'Exam', imagePath: examImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toBusScreen(context);
                    },
                    child:
                        const BuildIconCard(label: 'Bus', imagePath: theBusLocation,imageSize: 72,)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
