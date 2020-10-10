import 'package:diff_image/diff_image.dart';

final FIRST_IMAGE =
    'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png';
final SECOND_IMAGE =
    'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png';

void main() async {
  // You need a try/catch block to handle the exceptions (http request, different size, etc)
  try {
    // You can decide whether to take [alpha] into account for the calculation
    // of the difference. Also you can decide the format of the output: As
    // percentage or between 0 and 1.
    var diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
      ignoreAlpha: false,
      asPercentage: false,
    );
    showLog('The difference between images is: $diff');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
      ignoreAlpha: false,
    );
    showLog('The difference between images is: $diff percent');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
    );
    showLog('The difference between images is: $diff percent');

    // Uncomment and run this ONLY if you are not on Dart Web (saveDiff is not
    // supported on Dart Web yet). [saveDiff] allows you to save a png
    // showing the differences between the two images.

    /*
    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
      ignoreAlpha: false,
      saveDiff: true,
    );
    showLog('The difference between images is: $diff percent');
    */
  } catch (e) {
    showLog(e);
  }
}

void showLog(dynamic log) {
  // ignore: avoid_print
  print(log);
}
