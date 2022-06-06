import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yugioh_2021/services/service_index.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key, required this.onTextchanged})
      : super(key: key);
  final ValueChanged<String> onTextchanged;
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with CustomThemeMixin {
  @override
  Widget build(BuildContext context) {
    final theme = themeDisplayFor(context).currentTheme();
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: theme.typo.highLightText,
        cursorColor: theme.cardBackgroundColor,
        decoration: InputDecoration(
          hintStyle: theme.typo.disabledText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.disabledColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.cardBackgroundColor),
          ),
          hintText: 'Enter a search term',
        ),
        onChanged: (text) {
          widget.onTextchanged(text);
        },
      ),
    );
  }
}
