
# hashtagable 

[![test](https://github.com/santa112358/hashtagable/workflows/test/badge.svg)](https://github.com/santa112358/hashtagable/actions?query=workflow%3Atest) [![pub package](https://img.shields.io/pub/v/hashtagable.svg)](https://pub.dev/packages/hashtagable)

Widgets and functions to implement hashTag decorated text.

Decorates the words start with `#` like a Twitter.


![result](https://user-images.githubusercontent.com/43510799/76334550-88a32b00-6336-11ea-8209-baa65ede1ca1.gif)

## Usage

- **As InputText**

You can use `HashTagEditableText` to decorate input text.
```dart
    HashTagEditableText(
      controller: _textEditingController,
      cursorColor: Theme.of(context).cursorColor,
      basicStyle: TextStyle(fontSize: 14,color:Colors.black),
      focusNode: FocusNode(),
      onChanged: (_) {},
      onSubmitted: (_) {},
      decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
      hintText: "Type Here"
    ),
```
`decoratedStyle` is the textStyle of tagged text. `basicStyle` is for untagged text.




- **As ReadOnlyText**

<img src="https://user-images.githubusercontent.com/43510799/76335010-3a425c00-6337-11ea-98ed-d0bbf1cd4590.png" width = "265"/>

If you want to decorate the text only to display, `HashTagText` will help you.
```dart
    HashTagText(
        text: "#Hello world. Hello #world",
        decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
        basicStyle: TextStyle(fontSize: 14,color:Colors.black),
        onTap: (text) {
          print(text);
        },
    )
```

The argument `onTap(String)` is called when user tapped a hashTag. 

You can add some actions in this callback with the tapped hashTag.



## Customize your own hashTag features with some useful functions

- Check if the text has hashTags
```dart
   print(hasHashtags("Hello #World")); 
   // true
   
   print(hasHashtags("Hello World"));
   // false
   
```
- Extract hashTags from text
```dart
   final List<String> hashTags = extractHashTags("#Hello World #Flutter Dart #Thank you");
   // ["#Hello", "#Flutter", "#Thank"]

```


## Decoration rules

The rules are almost same as twitter. It does not decorate the tags which contain emoji or symbol.
It needs space before `#` to decorate.


<img src="https://user-images.githubusercontent.com/43510799/76335013-3c0c1f80-6337-11ea-8047-745082c52df4.png" width = "265"/>


