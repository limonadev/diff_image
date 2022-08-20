@TestOn('vm')

import 'package:diff_image/diff_image.dart';
import 'package:diff_image/src/helper_functions.dart';
import 'package:test/test.dart';

void main() {
  group('Test when dart:io is supported', () {
    late Uri flutterLogoUrl, dartLogoUrl, androidLogoUrl;

    setUp(() {
      // A real image
      flutterLogoUrl = Uri.parse(
          'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png');
      // Image with different size with respect to flutterLogoUrl
      dartLogoUrl = Uri.parse(
          'https://www.extremetech.com/wp-content/uploads/2011/10/dart-logo-banner1-348x196.jpg');
      // Image with the same size as flutterLogoUrl
      androidLogoUrl = Uri.parse(
          'https://seeklogo.com/images/A/android-western-logo-8F117A7F00-seeklogo.com.png');
    });

    test('Compare the same image', () async {
      var diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        flutterLogoUrl,
      );
      expect(diff.diffValue, 0);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        flutterLogoUrl,
        ignoreAlpha: false,
      );
      expect(diff.diffValue, 0);
    });

    test('Compare images with different size', () async {
      try {
        await DiffImage.compareFromUrl(
          flutterLogoUrl,
          dartLogoUrl,
        );
      } catch (e) {
        expect(e, isA<UnsupportedError>());
      }
    });

    test('Compare different images with same sizes', () async {
      var diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
      );
      expect(diff.diffValue, 34.83905183744361);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        ignoreAlpha: false,
      );
      expect(diff.diffValue, 35.67169421487167);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        asPercentage: false,
      );
      expect(diff.diffValue, 0.34839051837443613);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        ignoreAlpha: false,
        asPercentage: false,
      );
      expect(diff.diffValue, 0.3567169421487167);
    });

    test('Save image showing differences', () async {
      var diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
      );
      expect(diff.diffValue, 34.83905183744361);

      expect(
        () async {
          await DiffImage.saveDiffImg(
            diffImg: diff.diffImg,
          );
        },
        returnsNormally,
      );
    });

    test('Compare Image Files', () async {
      var firstImg = await getImg(
        imgSrc: flutterLogoUrl,
      );
      var secondImg = await getImg(
        imgSrc: androidLogoUrl,
      );

      var diff = await DiffImage.compareFromMemory(
        firstImg,
        secondImg,
      );
      expect(diff.diffValue, 34.83905183744361);
    });
  });
}
