import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/decorator.dart';

bool hasHashTags(String value) {
  final decoratedTextColor = Colors.blue;
  final decorator = Decorator(
      textStyle: TextStyle(),
      decoratedStyle: TextStyle(color: decoratedTextColor));
  final result = decorator.getDecorations(value);
  final taggedDecorations = result
      .where((decoration) => decoration.style.color == decoratedTextColor)
      .toList();
  return taggedDecorations.isNotEmpty;
}

List<String> extractHashTags(String value) {
  final decoratedTextColor = Colors.blue;
  final decorator = Decorator(
      textStyle: TextStyle(),
      decoratedStyle: TextStyle(color: decoratedTextColor));
  final decorations = decorator.getDecorations(value);
  final taggedDecorations = decorations
      .where((decoration) => decoration.style.color == decoratedTextColor)
      .toList();
  final result = taggedDecorations.map((decoration) {
    final text = decoration.range.textInside(value);
    return text.trim();
  }).toList();
  return result;
}

TextSpan getHashTagTextSpan(TextStyle decoratedStyle, TextStyle basicStyle,
    String source, Function(String) onTap) {
  final decorations =
      Decorator(decoratedStyle: decoratedStyle, textStyle: basicStyle)
          .getDecorations(source);
  if (decorations.isEmpty) {
    return TextSpan(text: source, style: basicStyle);
  } else {
    decorations.sort();
    final span = decorations
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
                    final decoration = decorations[index];
                    if (decoration.style == decoratedStyle) {
                      onTap(decoration.range.textInside(source));
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
