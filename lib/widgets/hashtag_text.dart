import 'package:flutter/cupertino.dart';
import 'package:hashtagable/hashtagable.dart';

/// Show decorated tagged text only to be shown
///
/// [decoratedStyle] is textStyle of tagged text.
/// [basicStyle] is textStyle of others.
/// [onTap] is called when a tagged text is tapped.
class HashTagText extends StatelessWidget {
  HashTagText(
      {required this.text,
      required this.basicStyle,
      required this.decoratedStyle,
      this.decorateAtSign = false,
      this.onTap,
      this.textAlign = TextAlign.start,
      this.textDirection,
      this.softWrap = true,
      this.overflow = TextOverflow.clip,
      this.textScaleFactor = 1.0,
      this.maxLines,
      this.locale,
      this.strutStyle,
      this.textWidthBasis = TextWidthBasis.parent,
      this.textHeightBehavior});

  final String text;
  final TextStyle basicStyle;
  final TextStyle decoratedStyle;
  final Function(String)? onTap;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final bool decorateAtSign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: getHashTagTextSpan(
          decoratedStyle: decoratedStyle,
          decorateAtSign: decorateAtSign,
          basicStyle: basicStyle,
          onTap: onTap,
          source: text),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
