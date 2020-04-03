/* 
** class to represent the characters that worked in starwars films.
*/
class CharactersModel{
  String id;
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String gender;
  List<int> films;
  String imageNetwork;

  CharactersModel.fromMappedJson(Map<String, dynamic> json) {
    
    name = json['name'] ?? "";
    height = json['height'] ?? "";
    mass = json['mass'] ?? "";
    hairColor = json['hair_color'] ?? "";
    skinColor = json['skin_color'] ?? "";
    eyeColor = json['eye_color'] ?? "";
    gender = json['gender'] ?? "";
    }
}

