import 'package:flutter/material.dart';
import 'package:yugioh/services/service_index.dart';
import 'package:intl/intl.dart';

import '../../presentional_index.dart';

class ThumnailCardSet extends StatelessWidget with CustomThemeMixin {
  const ThumnailCardSet({Key? key, required this.data}) : super(key: key);
  final ListVerticalCardSetModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeDisplayFor(context).currentTheme().cardBackgroundColor,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Stack(
        children: [
          // Image.network((data.images.isNotEmpty) ? data.images.first : ''),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    data.packName,
                    style:
                        themeDisplayFor(context).currentTheme().typo.cardText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '${data.totalCards} Cards',
                    style: themeDisplayFor(context)
                        .currentTheme()
                        .typo
                        .highLightTextSmall(),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    'Release date: ' +
                        ((data.releaseDate != null)
                            ? DateFormat.yMMMd(Localizations.localeOf(context)
                                    .languageCode)
                                .format(data.releaseDate!)
                            : '-'),
                    style: themeDisplayFor(context)
                        .currentTheme()
                        .typo
                        .highLightTextSmall(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
