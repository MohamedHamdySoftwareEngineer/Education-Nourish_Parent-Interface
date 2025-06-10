import 'package:edunourish/features/Settings%20Screen/presentation/views/widgets/settings_screen_body.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final int initialIndex;
  const SettingsScreen({super.key,required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SettingsScreenBody(initialIndex:initialIndex),
    );
  }
}
