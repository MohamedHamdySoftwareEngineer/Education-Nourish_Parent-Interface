import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/utils/app_router.dart';
import 'package:edunourish/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,required this.appBarTitle});
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
    
    border: Border(
      bottom: BorderSide(
        color: Colors.grey.shade300, // لون الخط
        width: 1,                     // سمك الخط
      ),
    ),
  ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 10, right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             
            InkWell(
                onTap: () {
                 AppRouter.toParentHome(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 30,
                  color: ourMainColor,
                )),
                Text(
                  appBarTitle,
                  style: mainText23,
                ),
            InkWell(
                onTap: () {
                  AppRouter.toNotifications(context);
                },
                child: const Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: ourMainColor,
                )),
            
          ],
        ),
      ),
    );
  }
}
