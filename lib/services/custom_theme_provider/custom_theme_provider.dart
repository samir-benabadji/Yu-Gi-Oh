import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomTypography {
  static TextStyle appFont = GoogleFonts.robotoCondensed();
  final TextStyle cardText = TextStyle(
    fontSize: 20,
    color: const Color(0xFFF8F8F8),
    fontFamily: appFont.fontFamily,
  );
  final TextStyle highLightText = TextStyle(
    fontSize: 14,
    color: const Color(0xFFFFD166),
    fontFamily: appFont.fontFamily,
  );
  final TextStyle disabledText = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    fontFamily: appFont.fontFamily,
  );
  highLightTextSmall() =>
      highLightText.copyWith(fontSize: 10, fontWeight: FontWeight.w100);
}

class CustomThemeData {
  final Color cardBackgroundColor = const Color(0xFF23262F);
  final Color displayBlockColor = const Color(0xFFffff7f);
  final Color appBackgroundColor = const Color(0xFF141416);
  final Color disabledColor = Colors.grey;
  final Color highlightColor = const Color(0xFFFFD166);
  final CustomTypography typo = CustomTypography();
  static Duration defaultAnimationDuration = const Duration(milliseconds: 800);
}

class ThemeNotifier with ChangeNotifier implements ReassembleHandler {
  CustomThemeData _themeData = CustomThemeData();
  ThemeNotifier(this._themeData);
  CustomThemeData currentTheme() => _themeData;
  setTheme(CustomThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  @override
  void reassemble() {
    setTheme(CustomThemeData());
  }
}

mixin CustomThemeMixin {
  ThemeNotifier themeDisplayFor(BuildContext context) {
    return Provider.of<ThemeNotifier>(context, listen: true);
  }

  ThemeNotifier themeControllerFor(BuildContext context) {
    return Provider.of<ThemeNotifier>(context, listen: false);
  }
}
