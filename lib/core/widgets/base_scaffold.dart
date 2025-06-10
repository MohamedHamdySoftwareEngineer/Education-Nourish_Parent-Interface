import 'package:smart_nav_bar/smart_nav_bar.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/utils/app_router.dart';
import 'package:edunourish/core/utils/assets.dart';
import 'package:flutter/material.dart';

import '../utils/custom_app_bar.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  final String appBartTitle;
  final bool wantAppBar;
  final int initialIndex;

  const BaseScaffold({
    super.key,
    required this.child,
    required this.appBartTitle,
    this.wantAppBar = true,
    this.initialIndex = 2, // Default to Home (index 2)
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _currentIndex; 

@override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildSmartNavBar(),
      appBar: (widget.wantAppBar == false) ? _buildAppBar() : null,
      body: Column(
        children: [
          if (widget.wantAppBar) CustomAppBar(appBarTitle: widget.appBartTitle,),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ourBackgroundColor,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
    
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      title: Row(
        children: [
          Image.asset(myLogo, height: 40),
          const Spacer(),
          InkWell(
            onTap: () => AppRouter.toNotifications(context),
            child: const Icon(Icons.notifications_none, size: 30, color: ourMainColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartNavBar() {
    return SmartBottomNav(
      currentIndex: _currentIndex,
   
      items: const [
        SmartNavItem(
          iconPath: listIcon, 
          label: 'List',
          activeColor: ourMainColor,
          inactiveColor: Colors.black54,
        ),
        SmartNavItem(
          iconPath: busIcon, 
          label: 'Bus',
          activeColor: ourMainColor,
          inactiveColor: Colors.black54,
        ),
        SmartNavItem(
          iconPath: homeIcon, 
          label: 'Home',
          activeColor: ourMainColor,
          inactiveColor: Colors.black54,
        ),
        SmartNavItem(
          iconPath: gradeIcon, 
          label: 'Grades',
          activeColor: ourMainColor,
          inactiveColor: Colors.black54,
        ),
        SmartNavItem(
          iconPath: settingsIcon, 
          label: 'Settings',
          activeColor: ourMainColor,
          inactiveColor: Colors.black54,
        ),
      ],
      onTap: (index) {
        if (index == _currentIndex) return;
        setState(() => _currentIndex = index);
        _navigateToScreen(index, context);
      },
    );
  }

  void _navigateToScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        AppRouter.toListScreen(context);
        break;
      case 1:
        AppRouter.toBusScreen(context);
        break;
      case 2:
        AppRouter.toParentHome(context);
        break;
      case 3:
        AppRouter.toGradeScreen(context);
        break;
      case 4:
        AppRouter.toSettingsScreen(context);
        break;
    }
  }
}