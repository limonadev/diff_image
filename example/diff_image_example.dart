import 'package:diff_image/diff_image.dart';

final FIRST_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-cs.png';
final SECOND_IMAGE = 'https://raw.githubusercontent.com/nicolashahn/diffimg/master/images/mario-circle-node.png';

main() async{

  try{
    var diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false, asPercentage: false);
    print('The difference between images is: $diff');

    diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false);
    print('The difference between images is: $diff percent');

    diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE);
    print('The difference between images is: $diff percent');


    //Only run this if you are not in Dart Web (saveDiff not supported yet in Dart Web)
    //diff = await DiffImage.compareFromUrl(FIRST_IMAGE, SECOND_IMAGE, ignoreAlpha: false, saveDiff: true);
    //print('The difference between images is: $diff percent');
  } catch(e){
    print(e);
  }

}
