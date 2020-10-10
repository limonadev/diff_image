import 'package:test/test.dart';
import 'package:diff_image/diff_image.dart';

void main() {
  group('Test when dart:io is supported', () {
    String flutterLogoUrl, dartLogoUrl, androidLogoUrl;

    setUp(() {
      // A real image
      flutterLogoUrl =
          'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png';
      // Image with different size with respect to flutterLogoUrl
      dartLogoUrl =
          'https://www.extremetech.com/wp-content/uploads/2011/10/dart-logo-banner1-348x196.jpg';
      // Image with the same size as flutterLogoUrl
      androidLogoUrl =
          'https://seeklogo.com/images/A/android-western-logo-8F117A7F00-seeklogo.com.png';
    });

    test('Compare the same image', () async {
      var diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        flutterLogoUrl,
      );
      expect(diff, 0);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        flutterLogoUrl,
        ignoreAlpha: false,
      );
      expect(diff, 0);
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
      expect(diff, 34.83905183744361);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        ignoreAlpha: false,
      );
      expect(diff, 35.67169421487167);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        asPercentage: false,
      );
      expect(diff, 0.34839051837443613);

      diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        ignoreAlpha: false,
        asPercentage: false,
      );
      expect(diff, 0.3567169421487167);
    });

    test('Save image showing differences', () async {
      var diff = await DiffImage.compareFromUrl(
        flutterLogoUrl,
        androidLogoUrl,
        saveDiff: true,
      );
      expect(diff, 34.83905183744361);
    });
  });
}
