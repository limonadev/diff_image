import 'package:image/image.dart';
import 'package:meta/meta.dart';
import 'helper_functions.dart';

class DiffImage {
  /// Returns a single number representing the difference between two RGB pixels
  static num _diffBetweenPixels({
    @required int firstPixel,
    @required bool ignoreAlpha,
    @required int secondPixel,
  }) {
    var fRed = getRed(firstPixel);
    var fGreen = getGreen(firstPixel);
    var fBlue = getBlue(firstPixel);
    var fAlpha = getAlpha(firstPixel);
    var sRed = getRed(secondPixel);
    var sGreen = getGreen(secondPixel);
    var sBlue = getBlue(secondPixel);
    var sAlpha = getAlpha(secondPixel);

    num diff =
        (fRed - sRed).abs() + (fGreen - sGreen).abs() + (fBlue - sBlue).abs();

    if (ignoreAlpha) {
      diff = (diff / 255) / 3;
    } else {
      diff += (fAlpha - sAlpha).abs();
      diff = (diff / 255) / 4;
    }

    return diff;
  }

  /// Returns a single number representing the average difference between each pixel
  static Future<num> compareFromUrl(
    dynamic firstImgSrc,
    dynamic secondImgSrc, {
    bool asPercentage = true,
    bool ignoreAlpha = true,
    bool saveDiff = false,
  }) async {
    var diff = 0.0;

    var firstImg = await getImg(
      imgSrc: firstImgSrc,
    );
    var secondImg = await getImg(
      imgSrc: secondImgSrc,
    );

    var imagesEqualSize = haveSameSize(
      firstImg: firstImg,
      secondImg: secondImg,
    );

    if (!imagesEqualSize) {
      throw UnsupportedError(
        'Currently we need images of same width and height',
      );
    }

    var width = firstImg.width;
    var height = firstImg.height;

    // Create an image to show the differences
    var diffImg = Image(width, height);

    for (var i = 0; i < width; i++) {
      num diffAtPixel, firstPixel, secondPixel;

      for (var j = 0; j < height; j++) {
        firstPixel = firstImg.getPixel(i, j);
        secondPixel = secondImg.getPixel(i, j);

        diffAtPixel = _diffBetweenPixels(
          firstPixel: firstPixel,
          ignoreAlpha: ignoreAlpha,
          secondPixel: secondPixel,
        );
        diff += diffAtPixel;

        diffImg.setPixel(
          i,
          j,
          selectColor(
            diffAtPixel: diffAtPixel,
            firstPixel: firstPixel,
            secondPixel: secondPixel,
          ),
        );
      }
    }

    diff /= height * width;

    if (asPercentage) diff *= 100;

    if (saveDiff) {
      //TODO Define if can download image file or just show
    }

    return diff;
  }
}
