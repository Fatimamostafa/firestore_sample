import 'package:flutter/material.dart';
import 'package:firestore_sample/values/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const LoadingIndicator(
      {super.key, this.size = 24.0, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: ColorsX.accent,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        value: null,
        strokeWidth: 3.0,
      ),
    );
  }
}
