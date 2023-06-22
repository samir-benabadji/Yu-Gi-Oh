import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final bool isDark;

  const BackgroundWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isDark ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Image.asset(
        'assets/screens/home_background.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
