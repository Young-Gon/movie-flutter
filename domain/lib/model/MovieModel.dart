// implements 대신 extends를 사용합니다.
import 'MediaModel.dart';

class MovieModel extends MediaModel {
  final bool adult;
  final String originalTitle;
  @override
  final String releaseDate;
  @override
  final String title;
  final bool video;

  MovieModel.fromJson(super.json)
    : adult = json['adult'] ?? false,
      originalTitle = json['original_title'] ?? '',
      releaseDate = json['release_date'] ?? '',
      title = json['title'] ?? '',
      video = json['video'] ?? false,
      super.fromJson();
}
