library hashtagable;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hashtagable/annotator.dart';
import 'package:provider/provider.dart';

import 'hint_text_controller.dart';

TextSpan getHashTagTextSpan(TextStyle decoratedStyle, TextStyle basicStyle,
    String source, Function(String) onTap) {
  final annotations =
      Annotator(decoratedStyle: decoratedStyle, textStyle: basicStyle)
          .getAnnotations(source);
  if (annotations.isEmpty) {
    return TextSpan(text: source, style: basicStyle);
  } else {
    annotations.sort();
    final span = annotations
        .asMap()
        .map(
          (index, item) {
            return MapEntry(
              index,
              TextSpan(
                style: item.style,
                text: item.range.textInside(source),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    final annotation = annotations[index];
                    if (annotation.style == decoratedStyle) {
                      onTap(annotation.range.textInside(source));
                    }
                  },
              ),
            );
          },
        )
        .values
        .toList();

    return TextSpan(children: span);
  }
}

class HashTagEditableText extends EditableText {
  HashTagEditableText({
    Key key,
    FocusNode focusNode,
    @required TextEditingController controller,
    @required TextStyle basicStyle,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    @required Color cursorColor,
    int maxLines,
    TextInputType keyboardType,
    bool autofocus,
    @required this.decoratedStyle,
  }) : super(
          key: key,
          focusNode: (focusNode) ?? FocusNode(),
          controller: controller,
          cursorColor: cursorColor,
          style: basicStyle,
          keyboardType: (keyboardType) ?? TextInputType.text,
          autocorrect: false,
          autofocus: (autofocus) ?? false,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          backgroundCursorColor: Colors.white,
          maxLines: maxLines,
        );

  final TextStyle decoratedStyle;

  @override
  HashTagEditableTextState createState() => HashTagEditableTextState();
}

/// EditableText which decorates the contents start with "#"
class HashTagEditableTextState extends EditableTextState {
  @override
  HashTagEditableText get widget => super.widget;

  Annotator annotator;

  @override
  void initState() {
    annotator = Annotator(
        textStyle: widget.style, decoratedStyle: widget.decoratedStyle);
    super.initState();
  }

  // NOTE checks if the text has hashtags
  static List<RegExpMatch> /*checkHashtags*/ (String value) {
    final hashTagRegExp = Annotator.hashTagRegExp;

    final tags = hashTagRegExp.allMatches(value).toList();

    return (tags.isEmpty) ? [] : tags;
  }

  @override
  TextSpan buildTextSpan() {
    final String sourceText = textEditingValue.text;
    final annotations = annotator.getAnnotations(sourceText);
    if (annotations.isEmpty) {
      return TextSpan(text: sourceText, style: widget.style);
    } else {
      annotations.sort();
      final span = annotations.map((item) {
        return TextSpan(
            style: item.style, text: item.range.textInside(sourceText));
      }).toList();

      return TextSpan(children: span);
    }
  }
}

class HashTagEditableTextWithHintText extends StatelessWidget {
  HashTagEditableTextWithHintText({
    Key key,
    this.controller,
    this.basicStyle,
    this.decoratedStyle,
    this.onChanged,
    this.onSubmitted,
    this.cursorColor,
    this.focusNode,
    this.maxLines,
    this.keyboardType,
    this.autofocus,
    this.hintText,
    this.hintTextStyle,
  });

  final TextEditingController controller;
  final TextStyle basicStyle;
  final TextStyle decoratedStyle;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Color cursorColor;
  final FocusNode focusNode;
  final int maxLines;
  final TextInputType keyboardType;
  final bool autofocus;
  final String hintText;
  final TextStyle hintTextStyle;

  @override
  Widget build(BuildContext context) {
    return (hintText != null)
        ? ChangeNotifierProvider(
            create: (_) => HintTextController(),
            child: Stack(
              children: [
                _HintText(hintText, hintTextStyle),
                _Body(),
              ],
            ),
          )
        : _Body();
  }
}

class _Body extends StatelessWidget {
  _Body({
    Key key,
    this.controller,
    this.basicStyle,
    this.decoratedStyle,
    this.onChanged,
    this.onSubmitted,
    this.cursorColor,
    this.focusNode,
    this.maxLines,
    this.keyboardType,
    this.autofocus,
  });

  final TextEditingController controller;
  final TextStyle basicStyle;
  final TextStyle decoratedStyle;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Color cursorColor;
  final FocusNode focusNode;
  final int maxLines;
  final TextInputType keyboardType;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HashTagEditableText(
      controller: controller ?? TextEditingController(),
      basicStyle: decoratedStyle ?? theme.textTheme.bodyText2,
      decoratedStyle: basicStyle ??
          theme.textTheme.bodyText2.copyWith(color: theme.accentColor),
      onChanged: (text) {
        Provider.of<HintTextController>(context, listen: false)
            .onChanged(onChanged, text);
      },
      onSubmitted: onSubmitted,
      cursorColor: cursorColor ?? theme.cursorColor,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      autofocus: autofocus,
    );
  }
}

class _HintText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  _HintText(this.text, this.textStyle);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Provider.of<HintTextController>(context).isContentEmpty
        ? Text(text,
            style: textStyle ??
                theme.textTheme.bodyText2.copyWith(color: theme.hintColor))
        : const SizedBox.shrink();
  }
}
