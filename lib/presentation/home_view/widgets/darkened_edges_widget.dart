import 'package:flutter/material.dart';
import 'package:yugioh_v2/presentation/home_view/widgets/home_menu.dart';

class DarkenedEdgesWidget extends StatefulWidget {
  final bool isDark;

  const DarkenedEdgesWidget({required this.isDark});

  @override
  _DarkenedEdgesWidgetState createState() => _DarkenedEdgesWidgetState();
}

class _DarkenedEdgesWidgetState extends State<DarkenedEdgesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    if (widget.isDark) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant DarkenedEdgesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDark != oldWidget.isDark) {
      if (widget.isDark) {
        _startAnimation();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isDark ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: child,
              );
            },
            child: HomeMenu(),
          ),
        ],
      ),
    );
  }
}
