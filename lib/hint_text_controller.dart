import 'package:flutter/cupertino.dart';

class HintTextController extends ChangeNotifier {
  bool isContentEmpty = true;

  void onChanged(ValueChanged<String> valueChanged, String text) {
    isContentEmpty = text.isEmpty;
    notifyListeners();
    valueChanged(text);
  }
}
