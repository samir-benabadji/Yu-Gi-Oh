import 'package:flutter/material.dart';

class MagicCircleProgressIndicator extends ProgressIndicator {
  final double? size;

  const MagicCircleProgressIndicator({
    Key? key,
    double? value,
    Color? color,
    Animation<Color?>? valueColor,
    this.size,
  }) : super(
          key: key,
          value: value,
          color: color,
          valueColor: valueColor,
        );

  @override
  State<StatefulWidget> createState() => _MagicCircleProgressIndicatorState();
}

class _MagicCircleProgressIndicatorState
    extends State<MagicCircleProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/magic_circle.gif',
    );
  }
}
