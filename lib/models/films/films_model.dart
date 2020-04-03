/* 
** class to represent the starwars films.
*/
class FilmsModel{
  String id;
  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String releaseDate;
  String episodeIdRoman;
  String imageNetwork;

  FilmsModel();

  FilmsModel.fromMappedJsonAll(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    episodeId = json['episode_id'] ?? 0;
    openingCrawl = json['opening_crawl'] ?? "";
    director = json['director'] ?? "";
    releaseDate = json['release_date'] ?? "";

  }
   FilmsModel.fromMappedJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    episodeId = json['episode_id'] ?? 0;
  }

}

