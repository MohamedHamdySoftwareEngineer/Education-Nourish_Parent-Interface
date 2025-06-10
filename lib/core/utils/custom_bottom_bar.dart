// import 'package:edunourish/core/utils/constants.dart';
// import 'package:edunourish/features/Parent/core/utils/app_router.dart';
// import 'package:edunourish/features/Parent/core/utils/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomBottomBar extends StatelessWidget {
//   const CustomBottomBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
    
//     border: Border(
//       top: BorderSide(
//         color: Colors.grey.shade300, // لون الخط
//         width: 1,                     // سمك الخط
//       ),
//     ),
//   ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Container(
//           color: Colors.transparent,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   AppRouter.toListScreen(context);
//                 },
//                 icon: const Icon(
//                   Icons.view_list,
//                   size: 33,
//                   color: ourMainColor,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppRouter.toBusScreen(context);
//                 },
//                 icon: const Icon(
//                   Icons.directions_bus_sharp,
//                   size: 33,
//                   color: ourMainColor,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppRouter.toParentHome(context);
//                 },
//                 icon: const Icon(
//                   Icons.home_filled,
//                   size: 33,
//                   color: ourMainColor,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppRouter.toGradeScreen(context);
//                 },
//                 icon: Image.asset(gradeImage, width: 30, height: 30),
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppRouter.toSettingsScreen(context);
//                 },
//                 icon: const Icon(
//                   Icons.settings_rounded, 
//                   size: 33,
//                   color: ourMainColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }