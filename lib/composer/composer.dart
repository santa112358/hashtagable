import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/decorator/decorator.dart' as decorator;

/// Add composing to hashtag decorated text.
///
/// Expected to be used when Japanese letters are typed.
class Composer {
  Composer({
    @required this.decorations,
    @required this.composing,
    @required this.sourceText,
    @required this.onDetectionTyped,
    @required this.selection,
    @required this.decoratedStyle,
  });

  final List<decorator.Decoration> decorations;
  final TextRange composing;
  final String sourceText;
  final ValueChanged<String> onDetectionTyped;
  final int selection;
  final TextStyle decoratedStyle;

  // TODO(Takahashi): Add test code for composing
  TextSpan getComposedTextSpan() {
    final span = decorations.map(
      (item) {
        final spanRange = item.range;
        final spanStyle = item.style;
        final underlinedStyle =
            spanStyle.copyWith(decoration: TextDecoration.underline);
        if (spanRange.start <= composing.start &&
            spanRange.end >= composing.end) {
          return TextSpan(
            children: [
              TextSpan(
                  text: TextRange(start: spanRange.start, end: composing.start)
                      .textInside(sourceText),
                  style: spanStyle),
              TextSpan(
                  text: TextRange(start: composing.start, end: composing.end)
                      .textInside(sourceText),
                  style: underlinedStyle),
              TextSpan(
                  text: TextRange(start: composing.end, end: spanRange.end)
                      .textInside(sourceText),
                  style: spanStyle),
            ],
          );
        } else if (spanRange.start >= composing.start &&
            spanRange.end >= composing.end &&
            spanRange.start <= composing.end) {
          return TextSpan(children: [
            TextSpan(
                text: TextRange(start: spanRange.start, end: composing.end)
                    .textInside(sourceText),
                style: underlinedStyle),
            TextSpan(
                text: TextRange(start: composing.end, end: spanRange.end)
                    .textInside(sourceText),
                style: spanStyle)
          ]);
        } else if (spanRange.start <= composing.start &&
            spanRange.end <= composing.end &&
            spanRange.end >= composing.start) {
          return TextSpan(
            children: [
              TextSpan(
                  text: TextRange(start: spanRange.start, end: composing.start)
                      .textInside(sourceText),
                  style: spanStyle),
              TextSpan(
                  text: TextRange(start: composing.start, end: spanRange.end)
                      .textInside(sourceText),
                  style: underlinedStyle),
            ],
          );
        } else {
          return TextSpan(
              text: spanRange.textInside(sourceText), style: spanStyle);
        }
      },
    ).toList();
    return TextSpan(children: span);
  }

  void callOnDetectionTyped() {
    final typingDecoration = decorations.firstWhere(
      (decoration) =>
          decoration.style == decoratedStyle &&
          decoration.range.start <= selection &&
          decoration.range.end >= selection,
      orElse: () {
        return null;
      },
    );
    if (typingDecoration != null) {
      onDetectionTyped(typingDecoration.range.textInside(sourceText));
    }
  }
}
