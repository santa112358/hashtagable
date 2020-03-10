## **Usage**

### **As EditableText**

```dart
    HashTagEditableText(
      controller: _textEditingController,
      cursorColor: Theme.of(context).cursorColor,
      basicStyle: TextStyle(fontSize: 14,color:Colors.black),
      focusNode: FocusNode(),
      onChanged: (_) {},
      onSubmitted: (_) {},
      decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
    ),
```
### **As RichText**
```dart
    RichText(
      text: getHashTagTextSpan(
          decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
          basicStyle: TextStyle(fontSize: 14,color:Colors.black),
          source: "#Hello world. Hello #world",
          onTap: (String text) {
            print(text);
          },
      ),
    ),
```