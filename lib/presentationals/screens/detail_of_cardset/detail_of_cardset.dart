import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh/bloc/bloc_index.dart';
import 'package:yugioh/presentationals/widgets/animated_opacity_on_appear/animated_opacity_on_appear.dart';
import 'package:yugioh/services/service_index.dart';

import '../../widgets/thumbnail_card_set/thumbnail_card_set.dart';

class DetailOfCardSet extends StatefulWidget {
  const DetailOfCardSet({Key? key}) : super(key: key);

  @override
  _DetailOfCardSetState createState() => _DetailOfCardSetState();
}

class _DetailOfCardSetState extends State<DetailOfCardSet>
    with CustomThemeMixin {
  Duration animatedItemDuration = Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeDisplayFor(context).currentTheme().cardBackgroundColor,
      body: SafeArea(
        child: Hero(
          tag: GlobalBloc.appStateBloc.focusedCardSet().idCardSet,
          child: Material(
            color: Colors.transparent,
            child: Container(
              // padding: EdgeInsets.all(10),
              color: themeDisplayFor(context).currentTheme().appBackgroundColor,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ThumnailCardSet(
                      data: GlobalBloc.appStateBloc.focusedCardSet()),
                  AnimatedOpacityOnAppear(
                    isShowed: true,
                    animatedItemDuration: animatedItemDuration,
                    child: CupertinoButton(
                        child: Text('back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
