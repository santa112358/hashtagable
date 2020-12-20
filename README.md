
# hashtagable 

[![test](https://github.com/santa112358/hashtagable/workflows/test/badge.svg)](https://github.com/santa112358/hashtagable/actions?query=workflow%3Atest) [![pub package](https://img.shields.io/pub/v/hashtagable.svg)](https://pub.dev/packages/hashtagable)
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>

Widgets and functions to implement hashTag decorated text.

Detects the words start with `#` like a Twitter.

![RPReplay_Final1599932903](https://user-images.githubusercontent.com/43510799/93001716-1d981280-f56c-11ea-8700-f181f7850455.gif)

## Usage

- **As TextField**

You can use `HashTagTextField` to decorate input text.
```dart
    HashTagTextField(
    decoratedStyle: TextStyle(fontSize: 14, color: Colors.blue),
    basicStyle: TextStyle(fontSize: 14, color: Colors.black),
    ),
```
`decoratedStyle` is the textStyle of tagged text. `basicStyle` is for untagged text.

Other arguments are basically same as those of material `TextField`




- **As ReadOnlyText**

If you want to decorate the text only to display, `HashTagText` will help you.
```dart
    HashTagText(
        text: "#Welcome to #hashtagable \n This is #ReadOnlyText",
        decoratedStyle: TextStyle(fontSize: 22,color:Colors.red),
        basicStyle: TextStyle(fontSize: 22,color:Colors.black),
        onTap: (text) {
          print(text);
        },
    )
```

The argument `onTap(String)` is called when user tapped a hashTag. 

You can add some actions in this callback with the tapped hashTag.


<img src ="https://user-images.githubusercontent.com/43510799/93002100-33f39d80-f56f-11ea-9855-83f2c095a1c4.jpg" width = "265"/>





## Customize with useful functions

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


## Tips

- [DetectableTextField](https://pub.dev/packages/detectable_text_field) is published as a refinement of this package. hashtagale forces you to use hashtag, but this one allows you to detect anything you want.

- If you also want to decorate At sign, you can do that by adding the argument `decorateAtSign: true`.
```dart
    HashTagText(
        text: "#Hello World @flutter_developers",
        decoratedStyle: TextStyle(fontSize: 14,color:Colors.red),
        basicStyle: TextStyle(fontSize: 14,color:Colors.black),
        onTap: (text) {
          print(text);
        },
        decorateAtSign: true,
    )
```
Then `HashTagText` and `HashtagTextField` come to decorate the words start with `#` or `@`.


- The decoration rules are almost same as twitter. It does not decorate the tags which contain emoji or symbol.
It needs space before `#` (or `@`) to decorate.

<img src ="https://user-images.githubusercontent.com/43510799/93002102-3655f780-f56f-11ea-8193-1753a69e23bc.jpg" width = "265"/>

- Supported Languages are English, Japanese, Korean, Spanish, Arabic, and Thai.


If you have any requests or questions, please feel free to ask on [github](https://github.com/santa112358/hashtagable/issues).


***

Contributors: [Santa Takahashi](https://github.com/santa112358), [Matheus Perez](https://github.com/matheusperez), [Marcel Schneider](https://github.com/SchnMar), [Ho Kim](https://github.com/kerryeon)
