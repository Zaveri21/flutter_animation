
## Flutter Animation
Effortlessly animate views or list items with the AnimationView kit by selecting an animation type. Options include: none, fadeIn, scale, slideRTL, slideLTR, slideUp, flip, bounce, scaleLTR, scaleCenterZoomOut. Enhance your UI seamlessly! 🚀✨

<a href="https://opensource.org/licenses/MIT" target="_blank"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"/></a>
<a href="https://opensource.org/licenses/Apache-2.0" target="_blank"><img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"/></a>
<a href="https://github.com/Zaveri21/flutter_awesome_animations_kit/issues" target="_blank">
    <img alt="GitHub: Zaveri21" src="https://img.shields.io/github/issues-raw/Zaveri21/flutter_awesome_animations_kit?style=flat" />
</a>
<img src="https://img.shields.io/github/last-commit/Zaveri21/flutter_awesome_animations_kit" />

### AnimationView Features

- ⭐️ **Multiple Animation Types**: Choose from a variety of animations like `none`, `fadeIn`, `scale`, `slideRTL`, `slideLTR`, `slideUp`, `flip`, `bounce`, `scaleLTR`, and `scaleCenterZoomOut`.
- ⭐️ **Full Customization**: fully customize the animations with `repeatMode` flag, duration, and curve settings to create unique effects.
- ⭐️ **Ease of Use**: Easily wrap around list items within an index or any normal widget without the `index` parameter.
- ⭐️ **Support for ListView**: When used with `ListView`, the `index` parameter is mandatory to ensure proper handling of list items.
- ⭐️ **Repeat Mode**: Enable or disable repeat mode for continuous animation loops.

### AnimatedText Features

- ⭐️ **Text Animations**: Provides `countDown`, `countUp`, `typing`, and `none` text animations.
- ⭐️ **Customizable Text**: Customize the text animations with start and end values, duration, curve, and text style.
- ⭐️ **Repeat Mode**: Enable or disable repeat mode for continuous animation loops.

<table>
  <tr>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_view.gif" alt="Animated View" width="300"></td>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_text.gif" alt="Animated Text" width="300"></td>
  </tr>
  <tr>
    <td align="center"><b>Animated View</b></td>
    <td align="center"><b>Animated Text</b></td>
  </tr>
</table>


## **Installation**
Add this package to `pubspec.yaml` as follows:

```console
$ flutter pub add flutter_awesome_animations_kit
```


```dart
import 'package:flutter_awesome_animations_kit/flutter_awesome_animations_kit.dart';
```

## Additional Information

Tell users more about the package: where to find more information, how to contribute to the package, how to file issues, what response they can expect from the package authors, and more.

## Usage

This package provides `AnimatedView` and `AnimatedText` widgets that you can use to add animations to your Flutter applications.

### AnimatedView Widget
The `AnimatedView` widget can wrap around list items within an index or any normal widget without the `index` parameter.

#### For ListView:
When using `AnimatedView` with a `ListView`, the `index` parameter is mandatory.

#### For Normal Widgets:
You can wrap any normal widget without needing the `index` parameter.

#### Animation Types
You can use the following animation types with full customization:

| Animation Type           | Description                                             |
|--------------------------|---------------------------------------------------------|
| `none`                   | No animation                                            |
| `fadeIn`                 | Fade in effect                                          |
| `scale`                  | Scale effect                                            |
| `slideRTL`               | Slide from right to left                                |
| `slideLTR`               | Slide from left to right                                |
| `slideUp`                | Slide up effect                                         |
| `flip`                   | Flip effect                                             |
| `bounce`                 | Bounce effect                                           |
| `scaleLTR`               | Scale from left to right (new)                          |
| `scaleCenterZoomOut`     | Centering circular view with zoom out effect (new)      |

#### Customization Options
You can customize the animations with:
- `repeatMode` : Set flag to `true` to enable continuous animation.
- `duration`: Set the duration property to customize the animation duration.
- `curve`: Set the curve property to customize the animation's easing effect.

#### Example

```dart
import 'package:flutter/material.dart';
import 'your_package_name/animated_view.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated View Example'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return AnimatedView(
            index: index,
            animationType: AnimationType.slideRTL, // set AnimationType 
            duration: Duration(milliseconds: 500), // set custom duration
            curve: Curves.easeInOut, // set curve
            repeatMode: true, // set repeatMode
            child: ListTile(
              title: Text('Item $index'),
            ),
          );
        },
      ),
    );
  }
}
```


### AnimatedText Widget
The `AnimatedText` widget provides animations for `countDown`, `countUp`, `typing`, and `none` text animations.

#### Animation Types
You can use the following animation types with full customization:

| Animation Type           | Description                                             |
|--------------------------|---------------------------------------------------------|
| `countUp`                | Animates text from a start value to an end value        |
| `countDown`              | Animates text from an end value to a start value        |
| `typing`                 | Typing animation for displaying text                    |
| `none`                   | No animation                                            |

#### Customization Options
You can customize the text animations with:
- `startValue` and `endValue`
- `duration`
- `curve`
- `style`
- `repeatMode`

#### Example

```dart
import 'package:flutter/material.dart';
import 'your_package_name/animated_text.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Text Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedText(
              normalText: "Hello...",
              animationType: TextAnimationType.typing,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            AnimatedText(
              startValue: 0, 
              endValue: 100.0,
              animationType: TextAnimationType.countDown,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            AnimatedText(
              startValue: 0,
              endValue: 100.0,
              animationType: TextAnimationType.countUp,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
```

## ⏳ Work-in-Progress (WIP)
- 🖥️ Web support (WIP) (Not tested on web platforms).

 ## Additional Information

Tell users more about the package: where to find more information, how to contribute to the package, how to file issues, what response they can expect from the package authors, and more.

### Support Me
<a href="https://www.buymeacoffee.com/vishaljhavu" target="_blank">
 <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 30px !important;width: 120px !important;">
</a>

### GitHub
<a href="https://github.com/Zaveri21/flutter_awesome_animations_kit">
  <img src="https://img.shields.io/github/stars/Zaveri21/flutter_awesome_animations_kit?style=social" alt="GitHub Stars" />
</a>
<a href="https://github.com/Zaveri21">
  <img src="https://img.shields.io/github/followers/Zaveri21?label=Follow&style=social" alt="GitHub Followers" />
</a>

### Say Thanks
<a href="https://saythanks.io/to/Zaveri21" target="_blank">
  <img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg" alt="Say Thanks" />
</a>

## License

<a href="/LICENSE">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT" style="style="height: 20px">
</a>

