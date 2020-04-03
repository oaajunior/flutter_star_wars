/* 
** auxiliary class to mount the REST API url.
*/

class UrlHelper {
  
  static const String BASE_URL = "https://swapi.co/api/";
  static const String BASE_URL_IMAGE =
      "https://raw.githubusercontent.com/oaajunior/flutter_project_images/master/images/";

  static String formURL(String endpoint) {
    return "${UrlHelper.BASE_URL}$endpoint";
  }

  static String fromURLImage(String endpoint) {
    return "${UrlHelper.BASE_URL_IMAGE}$endpoint";
  }
}