import 'package:flutter/material.dart';

class AnimatedOpacityOnAppear extends StatelessWidget {
  const AnimatedOpacityOnAppear({
    Key? key,
    required this.isShowed,
    required this.animatedItemDuration,
    required this.child,
  }) : super(key: key);

  final bool isShowed;
  final Duration animatedItemDuration;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isShowed ? 1.0 : 0.0,
      child: child,
      duration: animatedItemDuration,
    );
  }
}
