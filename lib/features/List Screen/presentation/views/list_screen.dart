import 'package:edunourish/features/List%20Screen/presentation/views/widgets/list_screen_body.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final int initialIndex;
  const ListScreen({super.key,required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListScreenBody(initialIndex: initialIndex),
    );
  }
}
