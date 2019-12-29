import 'package:image/image.dart';
import 'helper_functions.dart';

class DiffImage{

  ///Returns a single number representing the difference between two RGB pixels
  static num _diffBetweenPixels(firstPixel, secondPixel, ignoreAlpha){
    var fRed = getRed(firstPixel);     var fGreen = getGreen(firstPixel);
    var fBlue = getBlue(firstPixel);   var fAlpha = getAlpha(firstPixel);
    var sRed = getRed(secondPixel);    var sGreen = getGreen(secondPixel);
    var sBlue = getBlue(secondPixel);  var sAlpha = getAlpha(secondPixel);

    num diff = (fRed-sRed).abs() + (fGreen-sGreen).abs() + (fBlue-sBlue).abs();

    if( ignoreAlpha ) {diff = (diff/255) / 3;}
    else {
      diff += (fAlpha-sAlpha).abs();
      diff = (diff/255) / 4;
    }

    return diff;
  }

  ///Returns a single number representing the average difference between each pixel
  static Future<num> compareFromUrl(
      firstImgSrc, secondImgSrc,
      {ignoreAlpha=true, asPercentage=true, saveDiff=false}
      ) async{

    var firstImg = await getImg(firstImgSrc);
    if( firstImg is Exception ) throw firstImg;

    var secondImg = await getImg(secondImgSrc);
    if( secondImg is Exception ) throw secondImg;

    if( !haveSameSize(firstImg, secondImg) ){
      throw UnsupportedError('Currently we need images of same width and height');
    }

    var width = firstImg.width; var height = firstImg.height;
    var diff = 0.0;

    Image diffImg = Image(width, height);

    for(var i=0; i<width; i++){
      var diffAtPixel, firstPixel, secondPixel;
      for(var j=0; j<height; j++){
        firstPixel = firstImg.getPixel(i, j);
        secondPixel = secondImg.getPixel(i, j);
        diffAtPixel = _diffBetweenPixels(firstPixel, secondPixel, ignoreAlpha);
        diff += diffAtPixel;
        diffImg.setPixel(i, j, selectColor(firstPixel, secondPixel, diffAtPixel));
      }
    }

    diff /= height*width;

    if( asPercentage ) diff *= 100;

    if( saveDiff ) {
      //TODO Define if can download image file or just show
    }

    return diff;
  }

}