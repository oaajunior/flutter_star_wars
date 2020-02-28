class FilmsResponse {
  String title;
  int episodeId;

  FilmsResponse.fromMappedJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    episodeId = json['episode_id'] ?? 0;
  }

  FilmsResponse();
}
