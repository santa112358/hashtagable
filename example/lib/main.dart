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
              HashTagTextField(
                basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
