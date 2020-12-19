import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/decorator/decorator.dart' as decorator;

/// Add composing to hashtag decorated text.
class Composer {
  // TODO(Takahashi): Add test code for composing
  TextSpan getComposedTextSpan(
      {@required TextRange composing,
      @required List<decorator.Decoration> decorations,
      @required sourceText,
      @required ValueChanged<String> onDetectionTyped}) {
    final span = decorations.map(
      (item) {
        final spanRange = item.range;
        final spanStyle = item.style;
        final underlinedStyle =
            spanStyle.copyWith(decoration: TextDecoration.underline);
        final spanText = item.range.textInside(sourceText);
        if (spanRange.start <= composing.start &&
            spanRange.end >= composing.end) {
          onDetectionTyped?.call(spanText);
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
          onDetectionTyped?.call(spanText);
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
          onDetectionTyped?.call(spanText);
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
}
