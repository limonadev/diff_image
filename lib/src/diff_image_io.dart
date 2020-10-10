import 'dart:io' as io;

import 'package:image/image.dart';
import 'package:meta/meta.dart';
import 'helper_functions.dart';
import 'models/diff_img_result.dart';

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

  /// Computes the diffence between two images with the same width and heigth
  /// by receiving two URLs (one for each image). Retrieves both by using an
  /// HTTP request and returns a [DiffImgResult] containing two items:
  ///
  /// * An image showing the different pixels from both images.
  /// * The average difference between each pixel.
  ///
  /// Can throw an [Exception].
  static Future<DiffImgResult> compareFromUrl(
    dynamic firstImgSrc,
    dynamic secondImgSrc, {
    bool asPercentage = true,
    bool ignoreAlpha = true,
  }) async {
    var firstImg = await getImg(
      imgSrc: firstImgSrc,
    );
    var secondImg = await getImg(
      imgSrc: secondImgSrc,
    );

    return compareFromMemory(
      firstImg,
      secondImg,
      asPercentage: asPercentage,
      ignoreAlpha: ignoreAlpha,
    );
  }

  /// Computes the diffence between two images with the same width and heigth
  /// by receiving two [Image] objects (one for each image). Returns a
  /// [DiffImgResult] containing two items:
  ///
  /// * An image showing the different pixels from both images.
  /// * The average difference between each pixel.
  ///
  /// Can throw an [Exception].
  static DiffImgResult compareFromMemory(
    Image firstImg,
    Image secondImg, {
    bool asPercentage = true,
    bool ignoreAlpha = true,
  }) {
    var diff = 0.0;

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

        // Shows in red the different pixels and in semitransparent the same ones
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

    return DiffImgResult(
      diffImg: diffImg,
      diffValue: diff,
    );
  }

  /// Function to store an [Image] object as PNG in local storage.
  /// Not supported on web.
  static Future<void> saveDiffImg({
    @required Image diffImg,
  }) async {
    await io.File('DiffImg.png').writeAsBytes(
      encodePng(diffImg),
    );
  }
}
