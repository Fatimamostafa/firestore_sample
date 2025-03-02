import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final bool elevated;

  const CustomCard({
    super.key,
    required this.child,
    required this.borderRadius,
    this.elevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevated
          ? BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            )
          : BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}
