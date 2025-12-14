abstract class MediaModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  // Movie와 TV 모델에서 이름이 다른 공통 속성을 위한 getter
  String get title;
  String get releaseDate;

  // 공통 필드를 파싱하는 fromJson 생성자
  MediaModel.fromJson(Map<String, dynamic> json)
    : backdropPath = json['backdrop_path'],
      genreIds = List<int>.from(json['genre_ids'] ?? []),
      id = json['id'] ?? 0,
      originalLanguage = json['original_language'] ?? '',
      overview = json['overview'] ?? '',
      popularity = (json['popularity'] ?? 0.0).toDouble(),
      posterPath = json['poster_path'],
      voteAverage = (json['vote_average'] ?? 0.0).toDouble(),
      voteCount = json['vote_count'] ?? 0;
}
