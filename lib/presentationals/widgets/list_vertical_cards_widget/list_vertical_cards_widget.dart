import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yugioh_2021/routes/routes.dart';
import 'package:flutter_yugioh_2021/services/custom_theme_provider/custom_theme_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../presentional_index.dart';

class CardInfoOnVerticalListModel {
  final String cardName;
  final String cardImage;
  final String cardIndentifier;
  final String cardText;

  CardInfoOnVerticalListModel({
    required this.cardName,
    required this.cardImage,
    required this.cardIndentifier,
    required this.cardText,
  });
}

class ListVerticalCardsWidget extends StatefulWidget {
  final List<CardInfoOnVerticalListModel> cardsDisplay;
  const ListVerticalCardsWidget({
    Key? key,
    required this.cardsDisplay,
    this.onPressed,
  }) : super(key: key);
  final ValueChanged<CardInfoOnVerticalListModel>? onPressed;
  @override
  _ListVerticalCardsWidgetState createState() =>
      _ListVerticalCardsWidgetState();
}

class _ListVerticalCardsWidgetState extends State<ListVerticalCardsWidget>
    with CustomThemeMixin {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed!(widget.cardsDisplay[index]);
            }
          },
          child: _renderWithHero(index),
        );
      },
      itemCount: widget.cardsDisplay.length,
    );
  }

  Widget _renderWithHero(int index) {
    return Hero(
      tag: 'imageHero${widget.cardsDisplay[index].cardIndentifier}',
      child: Material(
          type: MaterialType.transparency, child: _renderNormally(index)),
    );
  }

  Widget _renderNormally(int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeDisplayFor(context).currentTheme().cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ThumnailCard(
        cardName: widget.cardsDisplay[index].cardName,
        imageLink: widget.cardsDisplay[index].cardImage,
        cardDeciption: widget.cardsDisplay[index].cardText,
      ),
    );
  }
}
