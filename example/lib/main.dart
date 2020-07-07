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
              Text("Without hint text "),
              const SizedBox(
                height: 8,
              ),

              /// You don't need to add decorated box. This is to make it visible
              DecoratedBox(
                decoration: BoxDecoration(border: Border.all()),
                child: HashTagEditableText(
                  decoratedStyle: TextStyle(fontSize: 14, color: Colors.black),
                  basicStyle: TextStyle(fontSize: 14, color: Colors.blue),
                  cursorColor: Theme.of(context).cursorColor,
                  controller: TextEditingController(),
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Text("With hint text "),
              const SizedBox(
                height: 8,
              ),

              /// You don't need to add decorated box. This is to make it visible
              DecoratedBox(
                decoration: BoxDecoration(border: Border.all()),
                child: HashTagEditableTextWithHintText(
                  hintText: "THIS IS HINT TEXT",
                  hintTextStyle: TextStyle(
                      fontSize: 14, color: Theme.of(context).hintColor),
                  basicStyle: TextStyle(fontSize: 14, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 14, color: Colors.blue),
                  cursorColor: Theme.of(context).cursorColor,
                  onChanged: (str) {
                    print(str);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
