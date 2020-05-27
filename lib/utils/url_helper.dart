/* 
** auxiliary class to mount the REST API url.
*/

class UrlHelper {
  
  static const String BASE_URL = "https://swapi.dev/api/";
  static const String BASE_URL_IMAGE =
      "https://raw.githubusercontent.com/oaajunior/flutter_project_images/master/images/";

  static String fromURL(String endpoint) {
    return "${UrlHelper.BASE_URL}$endpoint";
  }

  static String fromURLImage(String endpoint) {
    return endpoint != "" ? "${UrlHelper.BASE_URL_IMAGE}$endpoint" : "";
  }
}