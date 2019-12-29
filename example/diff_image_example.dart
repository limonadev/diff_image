import 'package:diff_image/diff_image.dart';

final FIRST_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png';
final SECOND_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png';

main() async{

  //You need a try/catch block to handle the exceptions (http request, different size, etc)
  try{
    //You can decide whether to take [alpha] into account for the calculation of the difference
    //Also you can decide the format of the output: As percentage or between 0 and 1
    var diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false, asPercentage: false);
    print('The difference between images is: $diff');

    diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false);
    print('The difference between images is: $diff percent');

    diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE);
    print('The difference between images is: $diff percent');


    //Only run this if you are not on Dart Web (saveDiff not supported yet on Dart Web)
    //saveDiff allows you to save a png showing the differences between the two images
    //diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false, saveDiff: true);
    //print('The difference between images is: $diff percent');
  } catch(e){
    print(e);
  }

}
