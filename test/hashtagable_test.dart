import 'package:flutter_test/flutter_test.dart';
import 'package:hashtagable/annotator.dart';

void main() {
  test("hashtagableTest", () {
    final source = "aaaa #あcdcdcd";
    final result = Annotator().getAnnotations(source);
    expect(result.length, 2);
  });
}
