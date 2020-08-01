import 'package:flutter/material.dart';
import 'package:hashtagable/decorator.dart';
import 'package:provider/provider.dart';

import 'hint_text_controller.dart';

/// Show decorated tagged text while user is inputting text.
///
/// [decoratedStyle] is textStyle of tagged text.
/// [basicStyle] is textStyle of others.
class HashTagEditableText extends StatelessWidget {
  HashTagEditableText({
    Key key,
    this.controller,
    this.basicStyle,
    this.decoratedStyle,
    this.onChanged,
    this.onSubmitted,
    this.cursorColor,
    this.focusNode,
    this.maxLines,
    this.minLines,
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
  final int minLines;
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
                _Body(
                  controller: this.controller,
                  onSubmitted: this.onSubmitted,
                  onChanged: this.onChanged,
                  maxLines: this.maxLines,
                  keyboardType: this.keyboardType,
                  key: this.key,
                  focusNode: this.focusNode,
                  cursorColor: this.cursorColor,
                  autofocus: this.autofocus,
                  basicStyle: this.basicStyle,
                  decoratedStyle: this.decoratedStyle,
                ),
              ],
            ),
          )
        : _Body(
            controller: this.controller,
            onSubmitted: this.onSubmitted,
            onChanged: this.onChanged,
            maxLines: this.maxLines,
            keyboardType: this.keyboardType,
            key: this.key,
            focusNode: this.focusNode,
            cursorColor: this.cursorColor,
            autofocus: this.autofocus,
            basicStyle: this.basicStyle,
            decoratedStyle: this.decoratedStyle,
          );
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
    this.minLines,
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
  final int minLines;
  final TextInputType keyboardType;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _EditableText(
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

/// TextWidget to show hintText
///
/// Its visibility is controlled by [HintTextController]
class _HintText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  _HintText(this.text, this.textStyle);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Provider.of<HintTextController>(context).isContentEmpty
        ? Text(text ?? "",
            style: textStyle ??
                theme.textTheme.bodyText2.copyWith(color: theme.hintColor))
        : const SizedBox.shrink();
  }
}

/// EditableText which decorates the contents start with "#"
class _EditableText extends EditableText {
  _EditableText({
    Key key,
    FocusNode focusNode,
    @required TextEditingController controller,
    @required TextStyle basicStyle,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    @required Color cursorColor,
    int maxLines,
    int minLines,
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
          minLines: minLines,
        );

  final TextStyle decoratedStyle;

  @override
  _EditableTextState createState() => _EditableTextState();
}

/// State of _EditableText
///
/// Return decorated tagged text by using functions in [Decorator]
class _EditableTextState extends EditableTextState {
  @override
  _EditableText get widget => super.widget;

  Decorator decorator;

  @override
  void initState() {
    decorator = Decorator(
        textStyle: widget.style, decoratedStyle: widget.decoratedStyle);
    super.initState();
  }

  @override
  TextSpan buildTextSpan() {
    final String sourceText = textEditingValue.text;
    final decorations = decorator.getDecorations(sourceText);
    if (decorations.isEmpty) {
      return TextSpan(text: sourceText, style: widget.style);
    } else {
      decorations.sort();
      final span = decorations.map((item) {
        return TextSpan(
            style: item.style, text: item.range.textInside(sourceText));
      }).toList();

      return TextSpan(children: span);
    }
  }
}
