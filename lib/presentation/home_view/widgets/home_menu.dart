import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../browse_view/browse_view.dart';
import '../../root_view/sound_controller.dart';
import '../../settings_view/settings_view.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  int _selectedIndex = -1;
  int _animationRepeatCount = 3;
  final SoundController _soundController = Get.find<SoundController>();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(
      begin: Colors.white.withOpacity(0.5),
      end: Colors.white,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * 0.85,
        height: Get.height * 0.325,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/screens/home_menu.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.black,
            width: 0.25,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuItem('DUEL MODE', 0),
            SizedBox(height: 8.0),
            _buildMenuItem('DECK CONSTRUCTION', 1),
            SizedBox(height: 8.0),
            _buildMenuItem('CARD LIST', 2),
            SizedBox(height: 8.0),
            _buildMenuItem('OPTIONS', 3),
            SizedBox(height: 8.0),
            _buildMenuItem('QUIT GAME', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        _startAnimation().then((_) {
          _executeMenuItemAction(index);
        });

        _soundController.playClickSound(); // Play the click sound effect
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'YuGiOhMatrix',
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: _getMenuItemColor(index),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Color _getMenuItemColor(int index) {
    if (_selectedIndex == index) {
      if (_animationController.isAnimating) {
        return _colorAnimation.value!;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white.withOpacity(0.7);
    }
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < _animationRepeatCount; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  void _executeMenuItemAction(int index) {
    // Execute the action only after the animation finishes
    switch (index) {
      case 0: // DUEL MODE
        // Implement the logic for navigating to the Duel Mode page
        break;
      case 1: // DECK CONSTRUCTION
        Get.to(() => SettingsView()); // Navigate to the SettingsView
        break;
      case 2: // CARD LIST
        Get.to(() => BrowseView()); // Navigate to the BrowseView
        break;
      case 3: // OPTIONS
        // Implement the logic for navigating to the Options page
        break;
      case 4: // QUIT GAME
        SystemNavigator.pop(); // Exit the app
        break;
      default:
        break;
    }
  }
}
