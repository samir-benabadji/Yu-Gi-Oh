import 'package:flutter/material.dart';
import 'package:flutter_yugioh_2021/routes/routes.dart';
import '../../../services/service_index.dart';
import '../../presentional_index.dart';
import 'main_screen_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.filterCards}) : super(key: key);
  final String filterCards;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with CustomThemeMixin {
  final mainScreenBloc = MainScreenBloc();
  String searchText = '';
  @override
  void initState() {
    super.initState();
    mainScreenBloc.acceptFilterName(widget.filterCards);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filterCards != oldWidget.filterCards) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeDisplayFor(context).currentTheme().appBackgroundColor,
      body: Column(
        children: [
          CustomSearchBar(
            onTextchanged: (String value) {
              setState(() {
                searchText = value;
                mainScreenBloc.acceptFilterName(value);
              });
            },
          ),
          Expanded(
            child: StreamBuilder<List<CardInfoOnVerticalListModel>>(
              stream: mainScreenBloc.observeAllcardsChange(),
              builder: (localContext, snapshot) {
                final List<CardInfoOnVerticalListModel> concreteData =
                    snapshot.data ?? [];
                if (concreteData.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                return ListVerticalCardsWidget(
                  cardsDisplay: concreteData,
                  onPressed: (itemPresses) {
                    mainScreenBloc.onFocusCardData(itemPresses.cardIndentifier);
                    Navigator.of(context).pushNamed(Routes.detailCard);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
