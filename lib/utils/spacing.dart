import 'package:flutter/widgets.dart';

/// How many pixels a spacing unit represents
const double kSpaceUnit = 8.0;

/// Converts a [number] of spacing units to pixels
double applySpacing(num number) => number * kSpaceUnit;

/// A [StatelessWidget] that assumes a [size] in spacing units in the
/// given [direction].
///
/// Commonly used under [Row], [Column] or [Flex] widgets
class Spacing extends StatelessWidget {
  /// The specified size in spacing units
  final double size;

  /// The direction in which the widget will be sized with [size]
  final Axis direction;

  /// Creates a [Spacing] instance with sane defaults
   const Spacing({Key? key,
    this.size = 1.0,
    this.direction = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sized = Size(applySpacing(size), 0);

    if (direction == Axis.horizontal) {
      return SizedBox.fromSize(
        size: sized,
      );
    }

    return SizedBox.fromSize(
      size: sized.flipped,
    );
  }
}
