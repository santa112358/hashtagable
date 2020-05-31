import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hashtagable/annotator.dart';

void main() {
  final decoratedColor = Colors.red;
  final undecoratedColor = Colors.black;
  final annotator = Annotator(
      textStyle: TextStyle(color: undecoratedColor),
      decoratedStyle: TextStyle(color: decoratedColor));
  test("Decorated text Always counted correctly", () {
    final source =
        "#tag1 あああ #tag2 #高橋3 #たぐ4 #タグ5 eww #tag6 #tag7 #tag8 ararara";
    final result = annotator.getAnnotations(source);
    final decoratedResult =
        result.where((item) => item.style.color == decoratedColor).toList();
    expect(decoratedResult.length, 8);
  });
  test("When source starts from '#',decorates the source", () {
    final source = "#aAア亜ｂＢ４";
    expect(annotator.getAnnotations(source).length, 1);
    expect(annotator.getAnnotations(source)[0].style.color, decoratedColor);
  });

  test("When source doesn't include any tags, return empty list", () {
    final source = "aaaaaaaaaaaaaa bbbbbbbbb";
    expect(annotator.getAnnotations(source).isEmpty, true);
  });

  test(
      "When source consists of [untagged, tagged], split it and decorate the tagged one",
      () {
    final source = "abcd #hogehoge";
    expect(annotator.getAnnotations(source).length, 2);
    expect(annotator.getAnnotations(source)[0].style.color, undecoratedColor);
    expect(annotator.getAnnotations(source)[1].style.color, decoratedColor);
  });

  test(
      "When source consists of [tagged, untagged], split it and decorate the tagged one",
      () {
    final source = "#hogehoge abcd";
    expect(annotator.getAnnotations(source).length, 2);
    expect(annotator.getAnnotations(source)[1].style.color, undecoratedColor);
    expect(annotator.getAnnotations(source)[0].style.color, decoratedColor);
  });

  test(
      "When source consists of [tagged, untagged], split it and decorate the first one",
      () {
    final source = "abcd #hogehoge #hugahuga abcde";
    expect(annotator.getAnnotations(source).length, 5);
    expect(annotator.getAnnotations(source)[0].style.color, undecoratedColor);
    expect(annotator.getAnnotations(source)[1].style.color, decoratedColor);
    expect(annotator.getAnnotations(source)[2].style.color, undecoratedColor);
    expect(annotator.getAnnotations(source)[3].style.color, decoratedColor);
    expect(annotator.getAnnotations(source)[4].style.color, undecoratedColor);
  });

  test("When tag includes emoji, split and undecorate the text after emoji",
      () {
    final source = "#abc😄def";
    expect(annotator.getAnnotations(source)[0].range,
        const TextRange(start: 0, end: 4));
    expect(annotator.getAnnotations(source)[0].style.color, decoratedColor);
  });

  test(
      "When tag doesn't include emoji but text does, it needs to decorate properly",
      () {
    final source = "#abc def😆";
    final res = annotator.getAnnotations(source);
    expect(res.length, 2);
    expect(res[0].style.color, decoratedColor);
    expect(res[1].style.color, undecoratedColor);
  });

  test("When tag includes symbol, split and undecorate the text after emoji",
      () {
    final source = "#abc!def";
    expect(annotator.getAnnotations(source)[0].range,
        const TextRange(start: 0, end: 4));
    expect(annotator.getAnnotations(source)[1].style.color, undecoratedColor);
  });

  test(" 'ー' must be contained in tagged text", () {
    final source = "#あーい";
    expect(annotator.getAnnotations(source)[0].range,
        const TextRange(start: 0, end: 4));
  });

  test("'_' must be contained in tagged text", () {
    final source = "#abc_def";
    expect(annotator.getAnnotations(source).length, 1);
  });

  test("Decoration mustn't started with \n", () {
    final source = "\n#hashtag";
    expect(annotator.getAnnotations(source).length, 2);
    expect(annotator.getAnnotations(source)[1].style.color, decoratedColor);
  });

  test("Stop decoration if it contains \n", () {
    final source = "#hash\ntag";
    expect(annotator.getAnnotations(source).length, 2);
    expect(annotator.getAnnotations(source)[0].style.color, decoratedColor);
  });
}
