import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildIconCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final double imageSize;

  /// [imageSize] controls the width & height of the image; defaults to 80.
  const BuildIconCard({
    Key? key,
    required this.label,
    required this.imagePath,
    this.imageSize = 90.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: ourMainColor,
          width: 3,
        ),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: ourMainTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
