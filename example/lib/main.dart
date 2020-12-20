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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// Tagged text only to be shown
                HashTagText(
                  text: "#Welcome to #hashtagable\n This is #ReadOnlyText",
                  basicStyle: TextStyle(fontSize: 22, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 22, color: Colors.red),
                  textAlign: TextAlign.center,
                  onTap: (text) {
                    print(text);
                  },
                ),
                HashTagTextField(
                  basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  /// Called when detection (words start with #, or # and @) is being typed
                  onDetectionTyped: (text) {
                    print(text);
                  },
                ),
                // TextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
