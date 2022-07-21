import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yugioh/bloc/bloc_index.dart';
import 'package:yugioh/presentationals/widgets/animated_opacity_on_appear/animated_opacity_on_appear.dart';
import '../../../services/service_index.dart';
import '../../widgets/thumnail_card/thumnail_card.dart';

class DetailOfCard extends StatefulWidget {
  const DetailOfCard({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailOfCard> createState() => _DetailOfCardState();
}

class _DetailOfCardState extends State<DetailOfCard> with CustomThemeMixin {
  bool isShowed = true;
  Duration animatedItemDuration = Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeDisplayFor(context).currentTheme().appBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Hero(
            tag: 'imageHero${GlobalBloc.appStateBloc.focusedCard().id}',
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: themeDisplayFor(context)
                        .currentTheme()
                        .cardBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.385,
                        child: ThumnailCard(
                          cardName:
                              GlobalBloc.appStateBloc.focusedCard().name ?? '',
                          imageLink: GlobalBloc.appStateBloc
                                  .focusedCard()
                                  .cardImages
                                  ?.first
                                  .imageUrl ??
                              '',
                          cardDeciption: '',
                        ),
                      ),
                      _renderWithAnimatedOpacity(
                        child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: themeDisplayFor(context)
                                  .currentTheme()
                                  .displayBlockColor,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: Center(
                            child: Text(
                              GlobalBloc.appStateBloc.focusedCard().desc ?? '',
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      _renderWithAnimatedOpacity(
                        child: CupertinoButton(
                          child: Container(
                            height: 30,
                            child: Text("back"),
                          ),
                          onPressed: () {
                            setState(() {
                              isShowed = false;
                            });
                            Future.delayed(animatedItemDuration, () {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderWithAnimatedOpacity({required Widget child}) {
    return AnimatedOpacityOnAppear(
      isShowed: isShowed,
      animatedItemDuration: animatedItemDuration,
      child: child,
    );
  }
}
