import 'package:app_star_wars/utils/url_helper.dart';

/* 
** auxiliary class with some usefull functions.
*/

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
        return number != null ? number.toString() : '';
    }
  }

  static String coverImageID({String id}) {
    return (id != null && id != "") ? "$id.jpg" : "";
  }

  static String networkImageID({String type, String id}) {
    var resultId = coverImageID(id: id);
    return UrlHelper.fromURLImage(
        ((type != null && type != "") && (resultId != null && resultId != ""))
            ? "$type/$resultId"
            : "");
  }

  static String treatDate(String date) {
    if (date == null || !date.contains('-')) {
      return '';
    }
    var arrayDate = date.split('-');
    return arrayDate[1] + '-' + arrayDate[2] + '-' + arrayDate[0];
  }

  static String extractID(String url) {
    if (!url.contains("/")) {
      return null;
    }
    var split = url.toString().split("/");
    split.removeLast();
    return split.last;
  }
}
