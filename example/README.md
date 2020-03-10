## **Usage**

### **As EditableText**

```dart
class MyHomePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HashTagEditableText(
              controller: _textEditingController,
              cursorColor: Theme.of(context).cursorColor,
              basicStyle: Theme.of(context).textTheme.headline,
              focusNode: FocusNode(),
              onChanged: (_) {},
              onSubmitted: (_) {},
              decoratedStyle: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

### **As RichText**
```dart
class MyHomePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: getHashTagTextSpan(
                decoratedStyle: TextStyle(fontSize: 14, color: Colors.red),
                basicStyle: TextStyle(fontSize: 14, color: Colors.black),
                source: "#Hello world. Hello #world",
                onTap: (text) {
                  print(text);
                },
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```