import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yugioh_2021/presentationals/presentional_index.dart';
import 'package:flutter_yugioh_2021/presentationals/screens/main_screen/main_screen.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_yugioh_2021/presentationals/screens/screen_index.dart';
import 'package:flutter_yugioh_2021/services/custom_theme_provider/custom_theme_provider.dart';

class CustomTabbarItem {
  final String label;
  final Icon icon;

  CustomTabbarItem({
    required this.label,
    required this.icon,
  });
}

class TabbarWithScreens extends StatefulWidget {
  const TabbarWithScreens({Key? key}) : super(key: key);

  @override
  State<TabbarWithScreens> createState() => _TabbarWithScreensState();
}

class _TabbarWithScreensState extends State<TabbarWithScreens>
    with SingleTickerProviderStateMixin, CustomThemeMixin {
  String filteredText = '';
  int _childIndex = 0;
  late TabController controller;
  final List<CustomTabbarItem> items = [
    CustomTabbarItem(
        icon: const Icon(PhosphorIcons.cards_bold), label: 'all cards'),
    CustomTabbarItem(
        icon: const Icon(PhosphorIcons.grid_four_bold), label: 'Cardset'),
    CustomTabbarItem(
        icon: const Icon(PhosphorIcons.gear_bold), label: 'settings'),
  ];
  @override
  void initState() {
    super.initState();
    controller =
        TabController(length: items.length, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = themeDisplayFor(context).currentTheme();
    return Scaffold(
      backgroundColor: theme.appBackgroundColor,
      body: SafeArea(
          child: TabBarView(
        controller: controller,
        children: [
          const MainScreen(
            filterCards: '',
          ),
          const CardSetScreen(),
          MainScreen(
            filterCards: filteredText,
          )
        ],
      )),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: theme.appBackgroundColor,
        selectedIndex: _childIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _childIndex = index;
            controller.index = index;
          });
        },
        items: _renderTabIcons(theme),
      ),
    );
  }

  List<FlashyTabBarItem> _renderTabIcons(CustomThemeData theme) {
    return items
        .map((e) => FlashyTabBarItem(
              icon: e.icon,
              title: Text(
                e.label.toUpperCase(),
                style: theme.typo.highLightText.copyWith(
                  color: theme.highlightColor,
                ),
              ),
              activeColor: theme.highlightColor,
              inactiveColor: theme.disabledColor,
            ))
        .toList();
  }
}
