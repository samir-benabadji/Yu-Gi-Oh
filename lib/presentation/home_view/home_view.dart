import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../root_view/sound_controller.dart';
import 'widgets/background_widget.dart';
import 'widgets/logo_widget.dart';
import 'widgets/darkened_edges_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isDark = false;
  final SoundController _soundController = Get.find<SoundController>();
  bool isClickSoundPreloaded = false;

  @override
  void initState() {
    super.initState();
    _soundController.playLaunchSoundtrack();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isDark = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _soundController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isClickSoundPreloaded) {
      _soundController.preloadClickSound();
      isClickSoundPreloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(
            isDark: isDark,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LogoWidget(
                showLogo: isDark,
              ),
              DarkenedEdgesWidget(
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
