import 'package:flutter/material.dart';
import 'package:yugioh/services/service_index.dart';

import '../../widgets/list_vertical_card_set_widget/list_vertical_card_set_widget.dart';
import 'cardset_screen_bloc.dart';

class CardSetScreen extends StatefulWidget {
  const CardSetScreen({Key? key}) : super(key: key);

  @override
  _CardSetScreenState createState() => _CardSetScreenState();
}

class _CardSetScreenState extends State<CardSetScreen> with CustomThemeMixin {
  CardSetScreenBloc archeTypeScreenBloc = CardSetScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeDisplayFor(context).currentTheme().appBackgroundColor,
      body: StreamBuilder<List<ListVerticalCardSetModel>>(
          stream: archeTypeScreenBloc.observeArcheType(),
          builder: (context, snapshot) {
            List<ListVerticalCardSetModel> data = snapshot.data ?? [];
            return ListVerticalCardSetWidget(cardSets: data);
          }),
    );
  }
}
