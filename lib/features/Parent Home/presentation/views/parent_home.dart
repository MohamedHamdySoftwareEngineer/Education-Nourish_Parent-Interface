import 'package:flutter/material.dart';

import 'widgets/parent_home_body.dart';

class ParentHome extends StatelessWidget {
  final int initialIndex;
  const ParentHome({super.key,required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ParentHomeBody(initialIndex: initialIndex),
    );
  }
}
