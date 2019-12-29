import 'package:http/http.dart' as http;
import 'package:image/image.dart';


///Through http get request to [imgSrc] obtain the bytes that make up an image
Future<dynamic> getImg(imgSrc) async{
  var response = await http.get(imgSrc);
  if( response.statusCode != 200 ){
    return Exception('imgSrc: $imgSrc has StatusCode http ${response.statusCode}');
  }
  var img = decodeImage(response.bodyBytes);
  if( img == null) return Exception('imgSrc: $imgSrc is not returning an Image');

  return img;
}

///Check if [firstImg] and [secondImg] have the same width and height
bool haveSameSize(firstImg, secondImg) {
  if( firstImg.width != secondImg.width ||
  firstImg.height != secondImg.height ){
    return false;
  }
  return true;
}

///Returns a red color only if two RGB pixels are different
int selectColor(firstPixel, secondPixel, diffAtPixel){
  var fRed = getRed(firstPixel);     var fGreen = getGreen(firstPixel);
  var fBlue = getBlue(firstPixel);
  var sRed = getRed(secondPixel);    var sGreen = getGreen(secondPixel);
  var sBlue = getBlue(secondPixel);

  if(diffAtPixel == 0) return Color.fromRgba(fRed, fGreen, fBlue, 50);
  if(fRed==0 && fGreen==0 && fBlue==0) return Color.fromRgba(sRed, sGreen, sBlue, 50);
  if(sRed==0 && sGreen==0 && sBlue==0) return Color.fromRgba(fRed, fGreen, fBlue, 50);

  int alpha, red, green, blue;

  alpha = 255;
  red = 255;
  green = 0;
  blue = 0;

  return Color.fromRgba(red, green, blue, alpha);
}