# diff_image

A Dart [Package](https://pub.dev/packages/diff_image) to get the % difference between two images of the same width and height.

diff_image is a Dart version of [this](https://github.com/nicolashahn/diffimg) with changes on visualization and , you guessed it, the language.

## Example

A simple usage example:

```dart
import 'package:diff_image/diff_image.dart';

final FIRST_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png';
final SECOND_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png';

void foo() async{
  try{
      var diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE);
      print('The difference between images is: $diff %');
  } catch(e){
      print(e);
  }
}

main() {
  foo();
}
```

A more detailed example can be found [here](https://github.com/limonadev/diff_image/tree/master/example)

## Features

1. Currently there is support only for images from the web (urls)
2. The `compareFromUrl` definition is:
```dart
     static Future<num> compareFromUrl(
           firstImgSrc, secondImgSrc,
           {ignoreAlpha=true, asPercentage=true, saveDiff=false}
           ) async{...}
```
where:
+ `ignoreAlpha` allows to decide whether to take alpha from RGBA into account for the calculation
+ `asPercentage` set the format of the output (as percentage or between 0-1)
+ `saveDiff` save a png showing the differences between [firstImgSrc] and [secondImgSrc] (currently not available on Dart Web)

## Sample Results
### First Image
![flutter_logo](https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png "Flutter Logo")
### Second Image
![android_logo](https://seeklogo.com/images/A/android-western-logo-8F117A7F00-seeklogo.com.png "Android Logo")
### Difference Percentage
**With Alpha    :** 35.67169421487167 %

**Without Alpha :** 34.83905183744361 %
### Difference Image
![DiffImg](https://raw.githubusercontent.com/limonadev/diff_image/master/DiffImg.png "DiffImg")


## Suggestions and bugs

Please file feature requests, suggestions and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/limonadev/diff_image/issues
