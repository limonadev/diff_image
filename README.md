# diff_image

A Dart [Package](https://pub.dev/packages/diff_image) to get the % difference between two images of the same width and height.

diff_image is a Dart version of [this](https://github.com/nicolashahn/diffimg) with changes on visualization and , you guessed it, the language.

## Example

A simple usage example:

```dart
import 'package:diff_image/diff_image.dart';
import 'package:image/image.dart';

final FIRST_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png';
final SECOND_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png';

void foo() async {
  try {
      var diff = await DiffImage.compareFromUrl(
        FIRST_IMAGE,
        SECOND_IMAGE,
      );
      print('The difference between images is: ${diff.value} %');
  } catch(e) {
      print(e);
  }
}

void goo(Image first, Image second) {
  try {
    var diff = DiffImage.compareFromMemory(
      first,
      second,
    );
    print('The difference between images is: ${diff.diffValue} %');
  } catch(e) {
    print(e);
  }
}

main() {
  foo();
  /*These can be obtained with any method*/
  Image first;
  Image second;
  // Here is posible to manipulate both images before passing them
  // to the function.
  goo(first, second);
}
```

A more detailed example can be found [here](https://github.com/limonadev/diff_image/tree/main/example)

## Features

1. Currently there is support for comparing images fetched from urls and from memory or storage.
2. The `compareFromUrl` definition is:
```dart
  static Future<DiffImgResult> compareFromUrl(
    dynamic firstImgSrc,
    dynamic secondImgSrc, {
    bool asPercentage = true,
    bool ignoreAlpha = true,
  }) async{...}
```
3. And the `compareFromMemory` definition is:
```dart
  static DiffImgResult compareFromMemory(
    Image firstImg,
    Image secondImg, {
    bool asPercentage = true,
    bool ignoreAlpha = true,
  }) {...}
```
where:
+ `ignoreAlpha` allows to decide whether to take alpha from RGBA into account for the calculation
+ `asPercentage` set the format of the output (as percentage or between 0-1)

Both methods return an `DiffImgResult`, a model which contains two elements: An image showing the differences between both images and the numeric value representing the difference (as percentage or not).

4. A function called `saveDiffImg` which saves a png showing the differences between `firstImg` and `secondImg` (currently not available on Dart Web).

## Sample Results
### First Image
![flutter_logo](https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png "Flutter Logo")
### Second Image
![android_logo](https://seeklogo.com/images/A/android-western-logo-8F117A7F00-seeklogo.com.png "Android Logo")
### Difference Percentage
**With Alpha    :** 35.67169421487167 %

**Without Alpha :** 34.83905183744361 %
### Difference Image
![DiffImg](https://raw.githubusercontent.com/limonadev/diff_image/main/DiffImg.png "DiffImg")


## Suggestions and bugs

Please file feature requests, suggestions and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/limonadev/diff_image/issues
