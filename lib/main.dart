import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh/presentationals/screens/detail_of_cardset/detail_of_cardset.dart';
import 'package:yugioh/presentationals/screens/tabbar_with_main_screens/tabbar_with_main_screens.dart';
import 'package:yugioh/routes/routes.dart';
import 'package:yugioh/services/service_index.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'presentationals/screens/detail_of_a_card/detail_of_a_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      
  ServiceFacade.registerDefaultService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(CustomThemeData()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: CustomTypography.appFont.fontFamily),
        home: const TabbarWithScreens(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.detailCard:
              return PageTransition(
                child: const DetailOfCard(),
                curve: Curves.bounceInOut,
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: CustomThemeData.defaultAnimationDuration,
                duration: CustomThemeData.defaultAnimationDuration,
              );
            case Routes.detailCardSet:
              return PageTransition(
                child: const DetailOfCardSet(),
                curve: Curves.bounceInOut,
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: CustomThemeData.defaultAnimationDuration,
                duration: CustomThemeData.defaultAnimationDuration,
              );
            default:
              return null;
          }
        },
        title: 'Yu Gi Oh cards & decks sets',
      ),
    );
  }
}
