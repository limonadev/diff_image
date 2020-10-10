/// A package to get the difference between two images through URLs

library diff_image;

export 'src/diff_image_io.dart'
    if (dart.library.io) 'src/diff_image_io.dart'
    if (dart.library.html) 'src/diff_image_html.dart';
