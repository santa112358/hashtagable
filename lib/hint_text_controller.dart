import 'package:flutter/cupertino.dart';
import 'package:hashtagable/hashtag_editable_text.dart';

/// Control the visibility of hintText in [HashTagEditableText].
class HintTextController extends ChangeNotifier {
  bool isContentEmpty = true;

  void onChanged(ValueChanged<String> valueChanged, String text) {
    isContentEmpty = text.isEmpty;
    notifyListeners();
    valueChanged(text);
  }
}
