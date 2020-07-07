import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/annotator.dart';

bool hasHashTags(String value) {
  final decoratedTextColor = Colors.blue;
  final annotator = Annotator(
      textStyle: TextStyle(),
      decoratedStyle: TextStyle(color: decoratedTextColor));
  final result = annotator.getAnnotations(value);
  final decoratedAnnotations = result
      .where((annotation) => annotation.style.color == decoratedTextColor)
      .toList();
  return decoratedAnnotations.isNotEmpty;
}

List<String> extractHashTags(String value) {
  final decoratedTextColor = Colors.blue;
  final annotator = Annotator(
      textStyle: TextStyle(),
      decoratedStyle: TextStyle(color: decoratedTextColor));
  final annotations = annotator.getAnnotations(value);
  final decoratedAnnotations = annotations
      .where((annotation) => annotation.style.color == decoratedTextColor)
      .toList();
  final result = decoratedAnnotations.map((annotation) {
    final text = annotation.range.textInside(value);
    return text.trim();
  }).toList();
  return result;
}

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
