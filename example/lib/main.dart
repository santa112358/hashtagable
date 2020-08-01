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
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Tagged text only to be shown
              HashTagText(
                text: "#Hello world. Hello #world",
                basicStyle: TextStyle(fontSize: 14, color: Colors.red),
                decoratedStyle: TextStyle(fontSize: 14, color: Colors.black),
              ),

              /// You don't need to add decorated box. This is to make it visible
              DecoratedBox(
                decoration: BoxDecoration(border: Border.all()),

                /// Decorate tagged input text
                child: HashTagEditableText(
                  hintTextStyle: TextStyle(
                      fontSize: 14, color: Theme.of(context).hintColor),
                  basicStyle: TextStyle(fontSize: 14, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 14, color: Colors.blue),
                  cursorColor: Theme.of(context).cursorColor,
                  onChanged: (str) {
                    print(str);
                  },
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
