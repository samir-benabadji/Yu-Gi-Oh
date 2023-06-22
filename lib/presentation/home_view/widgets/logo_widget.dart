import 'package:flutter/material.dart';

class LogoWidget extends StatefulWidget {
  final bool showLogo;

  const LogoWidget({required this.showLogo});

  @override
  _LogoWidgetState createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget>
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

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (widget.showLogo) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant LogoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showLogo != oldWidget.showLogo) {
      if (widget.showLogo) {
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
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showLogo,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: child,
          );
        },
        child: Image.asset(
          'assets/yugioh_logo.png',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
      ),
    );
  }
}
