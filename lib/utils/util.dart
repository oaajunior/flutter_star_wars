import 'package:app_star_wars/utils/url_helper.dart';

class Util {
  
  static String convertToRoman(int number) {
    switch (number) {
      case 1:
        return 'I';
        break;
      case 2:
        return 'II';
        break;
      case 3:
        return 'III';
        break;
      case 4:
        return 'IV';
        break;
      case 5:
        return 'V';
        break;
      case 6:
        return 'VI';
        break;
      case 7:
        return 'VII';
        break;
      default:
        return number.toString();
    }
  }

  static String coverImageID({String id}) {
    return "$id.jpg";
  }
  
  static String networkImageID({String type, String id}) {
    return UrlHelper.fromURLImage("$type$id.jpg");
  }

  static String treatDate(String date){
    var arrayDate = date.split('-');
    return arrayDate[1] + '-' +arrayDate[2] + '-' + arrayDate[0];
  }
}
