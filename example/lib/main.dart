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
                  decorateAtSign: true,
                  onTap: (text) {
                    print(text);
                  },
                ),
                HashTagTextField(
                  basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
                  keyboardType: TextInputType.multiline,
                  decorateAtSign: true,

                  /// Called when detection (word starts with #, or # and @) is being typed
                  onDetectionTyped: (text) {
                    print(text);
                  },

                  /// Called when detection is fully typed
                  onDetectionFinished: () {
                    print("detection finished");
                  },
                  maxLines: null,
                ),
                SizedBox(
                  height: 24,
                ),
                HashtagReadMoreText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Morbi nulla nisl, ornare #interdum efficitur sed, luctus '
                  'sit amet ex. In #condimentum molestie leo, quis placerat '
                  'diam sodales id. @Aenean semper sagittis elit id dignissim.'
                  ' Cras nec vulputate purus. Mauris vitae lacus sit amet dolor '
                  'scelerisque malesuada. #Vestibulum nunc arcu, ultricies vel '
                  'dapibus vel, consectetur in felis. Donec interdum est tempor '
                  'efficitur lacinia. Nam porttitor ante justo, ut pharetra '
                  'est convallis quis.',
                  basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                  decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
                  decorateAtSign: true,
                  textAlign: TextAlign.left,
                  onTap: (text) {
                    print(text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
