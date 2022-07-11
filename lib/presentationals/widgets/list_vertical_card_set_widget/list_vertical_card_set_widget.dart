import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh/bloc/bloc_index.dart';
import 'package:yugioh/routes/routes.dart';
import 'package:yugioh/services/custom_theme_provider/custom_theme_provider.dart';

import '../thumbnail_card_set/thumbnail_card_set.dart';

class ListVerticalCardSetModel {
  final String packName;
  final String idCardSet;
  final int totalCards;
  final DateTime? releaseDate;
  final List<String> images;
  ListVerticalCardSetModel({
    required this.packName,
    required this.idCardSet,
    required this.releaseDate,
    required this.images,
    required this.totalCards,
  });
}

class ListVerticalCardSetWidget extends StatefulWidget {
  const ListVerticalCardSetWidget({Key? key, required this.cardSets})
      : super(key: key);
  final List<ListVerticalCardSetModel> cardSets;
  @override
  _ListVerticalCardSetWidgetState createState() =>
      _ListVerticalCardSetWidgetState();
}

class _ListVerticalCardSetWidgetState extends State<ListVerticalCardSetWidget>
    with CustomThemeMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Hero(
          tag: widget.cardSets[index].idCardSet,
          child: Container(
            color: themeDisplayFor(context).currentTheme().appBackgroundColor,
            child: Align(
              alignment: Alignment.topCenter,
              child: CupertinoButton(
                child: ThumnailCardSet(data: widget.cardSets[index]),
                onPressed: () {
                  GlobalBloc.appStateBloc.acceptCardSet(widget.cardSets[index]);
                  Navigator.of(context).pushNamed(Routes.detailCardSet);
                },
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        );
      },
      itemCount: widget.cardSets.length,
    );
  }
}
