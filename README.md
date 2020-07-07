
# hashtagable [![pub package](https://img.shields.io/pub/v/hashtagable.svg)](https://pub.dev/packages/hashtagable)
Widget and function to implement hashtag-decorated EditableText and RichText.
It decorates the words start with `#`


![result](https://user-images.githubusercontent.com/43510799/76334550-88a32b00-6336-11ea-8209-baa65ede1ca1.gif)

## Usage

- **As EditableText**

If you want to decorate input text, `HashTagEditableText` will help you.
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
`decoratedStyle` is the textStyle of tagged text. `basicStyle` is that of untagged text.




- **As RichText**

<img src="https://user-images.githubusercontent.com/43510799/76335010-3a425c00-6337-11ea-98ed-d0bbf1cd4590.png" width = "265"/>

If you want to decorate the text only to display, `getHashTagTextSpan()` will help you.
All you need to do is just putting this function in `RichText`.
```dart
    RichText(
      text: getHashTagTextSpan(
          decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
          basicStyle: TextStyle(fontSize: 14,color:Colors.black),
          source: "#Hello world. Hello #world",
          onTap: (text) {
            print(text);
          },
      ),
    ),
```

The argument `onTap(String)` is called when user tapped tagged text.

## Customize hashtag features

- Check if the text has hashtags
```dart
   final hasHashTags = hasHashtags("Hello #World"); 
   // true
   
   final hasHashtags = hasHashtags("Hello World");
   // false
   
```
- Extract hashtags from text
```dart
   /// Extract hashtags from text
   final List<String> hashtags = extractHashtags("#Hello World #Flutter Dart #Thank you");
   // ["#Hello", "#Flutter", "#Thank"]

```



## Decoration rules

The rules are almost same as twitter. It doesn't decorate the tags which contain emoji or symbol.
It needs space before `#` to decorate.


<img src="https://user-images.githubusercontent.com/43510799/76335013-3c0c1f80-6337-11ea-8047-745082c52df4.png" width = "265"/>


