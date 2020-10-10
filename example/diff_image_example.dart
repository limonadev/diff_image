import 'package:diff_image/diff_image.dart';
import 'package:http/http.dart' as http;

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
    showLog('The difference between images is: ${diff.diffValue}');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
      ignoreAlpha: false,
    );
    showLog('The difference between images is: ${diff.diffValue} percent');

    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
    );
    showLog('The difference between images is: ${diff.diffValue} percent');

    // To allow more flexibility with the package, now it's possible to get
    // the difference between two images directly from the local memory.
    var firstImageFromMemory = await _loadImage(FIRST_IMAGE);
    var secondImageFromMemory = await _loadImage(SECOND_IMAGE);
    diff = DiffImage.compareFromMemory(
      firstImageFromMemory,
      secondImageFromMemory,
    );
    showLog('The difference between images is: ${diff.diffValue} percent');

    // Uncomment and run this ONLY if you are not on Dart Web (saveDiffImg
    // is not supported on Dart Web yet). [saveDiffImg] allows you to save
    // a png showing the differences between the two images.

    /*
    diff = await DiffImage.compareFromUrl(
      FIRST_IMAGE,
      SECOND_IMAGE,
      ignoreAlpha: false,
    );
    showLog('The difference between images is: ${diff.diffValue} percent');
    await DiffImage.saveDiffImg(
      diffImg: diff.diffImg,
    );
    */
  } catch (e) {
    showLog(e);
  }
}

void showLog(dynamic log) {
  // ignore: avoid_print
  print(log);
}

Future<Image> _loadImage(String imgSrc) async {
  var response = await http.get(imgSrc);
  var img = decodeImage(response.bodyBytes);
  return img;
}
