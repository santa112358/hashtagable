library hashtagable;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hashtagable/annotator.dart';

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
    TextEditingController controller,
    TextStyle basicStyle,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    Color cursorColor,
    int maxLines,
    TextInputType keyboardType,
    bool autofocus,
    this.decoratedStyle,
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
