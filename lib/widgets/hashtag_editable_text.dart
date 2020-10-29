import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashtagable/decorator/decorator.dart';

int _obscureShowCharTicksPending = 0;
int _obscureLatestCharIndex;

/// Show decorated tagged text while user is inputting text.
///
/// [decoratedStyle] is textStyle of tagged text.
/// [basicStyle] is textStyle of others.
/// EditableText which decorates the contents start with "#"
class HashTagEditableText extends EditableText {
  HashTagEditableText({
    Key key,
    FocusNode focusNode,
    @required TextEditingController controller,
    @required TextStyle basicStyle,
    @required this.decoratedStyle,
    @required Color cursorColor,
    this.decorateAtSign,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    int maxLines,
    int minLines,
    TextInputType keyboardType,
    bool autofocus,
    bool obscureText = false,
    bool readOnly = false,
    bool forceLine = true,
    ToolbarOptions toolbarOptions = const ToolbarOptions(
      copy: true,
      cut: true,
      paste: true,
      selectAll: true,
    ),
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    StrutStyle strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Locale locale,
    double textScaleFactor,
    bool expands = false,
    Color selectionColor,
    TextSelectionControls selectionControls,
    TextInputAction textInputAction,
    VoidCallback onEditingComplete,
    SelectionChangedCallback onSelectionChanged,
    VoidCallback onSelectionHandleTapped,
    List<TextInputFormatter> inputFormatters,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    bool cursorOpacityAnimates = false,
    Offset cursorOffset,
    bool paintCursorAboveText = false,
    BoxHeightStyle selectionHeightStyle = BoxHeightStyle.tight,
    BoxWidthStyle selectionWidthStyle = BoxWidthStyle.tight,
    Brightness keyboardAppearance = Brightness.light,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollController scrollController,
    ScrollPhysics scrollPhysics,
    bool showCursor,
    bool showSelectionHandles = false,
    bool rendererIgnoresPointer = true,
    Color backgroundCursorColor = CupertinoColors.inactiveGray,
    bool enableInteractiveSelection = true,
  }) : super(
          key: key,
          focusNode: (focusNode) ?? FocusNode(),
          controller: controller,
          cursorColor: cursorColor,
          style: basicStyle,
          keyboardType: (keyboardType) ?? TextInputType.text,
          autofocus: (autofocus) ?? false,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          backgroundCursorColor: backgroundCursorColor,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: obscureText,
          readOnly: readOnly,
          forceLine: forceLine,
          toolbarOptions: toolbarOptions,
          autocorrect: autocorrect ?? false,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          enableSuggestions: enableSuggestions ?? false,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          textCapitalization: textCapitalization,
          locale: locale,
          textScaleFactor: textScaleFactor,
          expands: expands,
          selectionColor: selectionColor,
          selectionControls: selectionControls,
          textInputAction: textInputAction,
          onEditingComplete: onEditingComplete,
          onSelectionChanged: onSelectionChanged,
          onSelectionHandleTapped: onSelectionHandleTapped,
          inputFormatters: inputFormatters,
          cursorWidth: cursorWidth,
          cursorRadius: cursorRadius,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorOffset: cursorOffset,
          paintCursorAboveText: paintCursorAboveText,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          dragStartBehavior: dragStartBehavior,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          showCursor: showCursor,
          showSelectionHandles: showSelectionHandles,
          rendererIgnoresPointer: rendererIgnoresPointer,
          enableInteractiveSelection: enableInteractiveSelection,
        );

  final TextStyle decoratedStyle;

  final decorateAtSign;

  @override
  HashTagEditableTextState createState() => HashTagEditableTextState();
}

/// State of [HashTagEditableText]
///
/// Return decorated tagged text by using functions in [Decorator]
class HashTagEditableTextState extends EditableTextState {
  @override
  HashTagEditableText get widget => super.widget;

  Decorator decorator;

  @override
  void initState() {
    decorator = Decorator(
        textStyle: widget.style,
        decoratedStyle: widget.decoratedStyle,
        decorateAtSign: widget.decorateAtSign);
    super.initState();
  }

  @override
  TextSpan buildTextSpan() {
    final String sourceText = textEditingValue.text;
    final decorations = decorator.getDecorations(sourceText);
    if (decorations.isEmpty) {
      return widget.controller.buildTextSpan(
        style: widget.style,
        withComposing: !widget.readOnly,
      );
    } else {
      decorations.sort();
      final composing = widget.controller.value.composing;
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
                    text:
                        TextRange(start: spanRange.start, end: composing.start)
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
                    text:
                        TextRange(start: spanRange.start, end: composing.start)
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
      // final span = decorations
      //     .asMap()
      //     .map(
      //       (index, item) {
      //         return MapEntry(
      //           index,
      //           composingDecoration(
      //             style: item.style,
      //             textRange: item.range,
      //             text: item.range.textInside(sourceText),
      //           ),
      //         );
      //         // return composingDecoration(
      //         //     style: item.style,
      //         //     textRange: item.range,
      //         //     text: item.range.textInside(sourceText));
      //         // return TextSpan(
      //         //     style: item.style, text: item.range.textInside(sourceText));
      //       },
      //     )
      //     .values
      //     .toList();

      return TextSpan(children: span);
    }
  }

  TextSpan composingDecoration(
      {TextStyle style, TextRange textRange, String text}) {
    final value = widget.controller.value;
    final withComposing = !widget.readOnly;
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    if (textRange.start > value.composing.start) {
      return TextSpan(text: text, style: style);
    } else if (textRange.end < value.composing.end) {}
    final range1 =
        TextRange(start: textRange.start, end: value.composing.start);
    final range2 = TextRange(start: value.composing.start, end: textRange.end);
  }
}
