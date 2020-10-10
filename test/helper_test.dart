@TestOn('vm')

import 'package:test/test.dart';
import 'package:image/image.dart';

import 'package:diff_image/src/helper_functions.dart';

void main() {
  group('Test for helper functions', () {
    String flutterLogoUrl, badUrl, anotherLogoUrl;

    setUp(() {
      // A real image
      flutterLogoUrl =
          'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png';
      // Not an image
      badUrl = 'https://seeklogo.com';
      // Image with different size with respect to flutterLogoUrl
      anotherLogoUrl =
          'https://www.extremetech.com/wp-content/uploads/2011/10/dart-logo-banner1-348x196.jpg';
    });

    test('Get image from url', () async {
      var first = await getImg(
        imgSrc: flutterLogoUrl,
      );
      expect(first, isA<Image>());
      expect(
        () async {
          await getImg(
            imgSrc: badUrl,
          );
        },
        throwsException,
      );
    });

    test('Compare images size', () async {
      var img1 = await getImg(
        imgSrc: flutterLogoUrl,
      );
      var areEquals = haveSameSize(
        firstImg: img1,
        secondImg: img1,
      );
      expect(areEquals, isTrue);

      var img2 = await getImg(
        imgSrc: anotherLogoUrl,
      );
      areEquals = haveSameSize(
        firstImg: img1,
        secondImg: img2,
      );
      expect(areEquals, isFalse);
    });
  });
}
