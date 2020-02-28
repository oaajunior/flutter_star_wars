class FilmsAllResponse{
  String id;
  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String releaseDate;
  String episodeIdRoman;
  String imageID;

  FilmsAllResponse.fromMappedJson(Map<String, dynamic> json) {
    
    //var results = json['results'];
    title = json['title'] ?? "";
    episodeId = json['episode_id'] ?? 0;
    openingCrawl = json['opening_crawl'] ?? "";
    director = json['director'] ?? "";
    releaseDate = json['release_date'] ?? "";

  }
}

