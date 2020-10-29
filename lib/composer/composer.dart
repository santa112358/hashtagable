import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/decorator/decorator.dart' as decorator;

class Composer {
  // TODO(Takahashi): Add test code for composing
  TextSpan getComposedTextSpan(
      {@required TextRange composing,
      @required List<decorator.Decoration> decorations,
      @required sourceText}) {
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
}
