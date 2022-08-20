import 'dart:io';

import 'package:diff_image/diff_image.dart';
import 'package:image/image.dart';

void main() async {
  final FIRST_IMAGE_URL = Uri.parse(
      'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png');
  final SECOND_IMAGE_URL = Uri.parse(
      'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png');

  // You need a try/catch block to handle the exceptions (http request, different size, etc)
  try {
    // You can decide whether to take [alpha] into account for the calculation
    // of the difference. Also you can decide the format of the output: As
    // percentage or between 0 and 1.
    var diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE_URL,
      SECOND_IMAGE_URL,
      ignoreAlpha: false,
      asPercentage: false,
    );
    print('The difference between images is: ${diff.diffValue}');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE_URL,
      SECOND_IMAGE_URL,
      ignoreAlpha: false,
    );
    print('The difference between images is: ${diff.diffValue} percent');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE_URL,
      SECOND_IMAGE_URL,
    );
    print('The difference between images is: ${diff.diffValue} percent');

    // To allow more flexibility with the package, now it's possible to get
    // the difference between two images directly from the local memory.
    var firstImageFromMemory = decodeImage(
      File(
        'assets/mario-circle-cs.png',
      ).readAsBytesSync(),
    );
    var secondImageFromMemory = decodeImage(
      File(
        'assets/mario-circle-node.png',
      ).readAsBytesSync(),
    );
    diff = DiffImage.compareFromMemory(
      firstImageFromMemory,
      secondImageFromMemory,
    );
    print('The difference between images is: ${diff.diffValue} percent');

    // Uncomment and run this ONLY if you are not on Dart Web (saveDiffImg
    // is not supported on Dart Web yet). [saveDiffImg] allows you to save
    // a png showing the differences between the two images.

    /*
    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE_URL,
      SECOND_IMAGE_URL,
      ignoreAlpha: false,
    );
    print('The difference between images is: ${diff.diffValue} percent');
    await DiffImage.saveDiffImg(
      diffImg: diff.diffImg,
    );
    */
  } catch (e) {
    print(e);
  }
}
