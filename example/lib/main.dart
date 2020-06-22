import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RichText(
            text: getHashTagTextSpan(
              TextStyle(fontSize: 14, color: Colors.red),
              TextStyle(fontSize: 14, color: Colors.black),
              "#Hello world. Hello #world",
              (text) {
                print(text);
              },
            ),
          ),
          HashTagEditableText(
            decoratedStyle: TextStyle(fontSize: 14, color: Colors.black),
            basicStyle: TextStyle(fontSize: 14, color: Colors.blue),
            cursorColor: Theme.of(context).cursorColor,
            controller: TextEditingController(),
          ),
          HashTagEditableTextWithHintText(
            hintText: "THIS IS HINT TEXT",
            hintTextStyle:
                TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
            basicStyle: TextStyle(fontSize: 14, color: Colors.black),
            decoratedStyle: TextStyle(fontSize: 14, color: Colors.blue),
            cursorColor: Theme.of(context).cursorColor,
          ),
        ],
      ),
    );
  }
}
