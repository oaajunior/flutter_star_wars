class CharactersAllResponse{
  String id;
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String gender;
  List<int> films;
  String imageID;

  CharactersAllResponse.fromMappedJson(Map<String, dynamic> json) {
    
    name = json['name'] ?? "";
    height = json['height'] ?? "";
    mass = json['mass'] ?? "";
    hairColor = json['hair_color'] ?? "";
    skinColor = json['skin_color'] ?? "";
    eyeColor = json['eye_color'] ?? "";
    gender = json['gender'] ?? "";
    }
}
