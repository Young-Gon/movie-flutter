import 'package:movie/data/model/MediaDetail.dart';
import 'package:movie/data/model/MovieModel.dart';

// MovieModel을 상속하고 MediaDetailMixin을 with합니다.
class MovieDetailModel extends MovieModel with MediaDetailMixin {
  final Map<String, dynamic>? belongsToCollection;
  final int budget;
  final String? imdbId;
  final int revenue;
  final int? runtime;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
    // 1. MovieModel의 고유 필드 파싱
    : belongsToCollection = json['belongs_to_collection'],
      budget = json['budget'] ?? 0,
      imdbId = json['imdb_id'],
      revenue = json['revenue'] ?? 0,
      runtime = json['runtime'],
      // 2. 부모 MovieModel의 fromJson 호출
      super.fromJson(json) {
    // 3. Mixin의 필드를 초기화합니다.
    genres = (json['genres'] as List? ?? [])
        .map((e) => Genre.fromJson(e))
        .toList();
    homepage = json['homepage'];
    productionCompanies = (json['production_companies'] as List? ?? [])
        .map((e) => ProductionCompany.fromJson(e))
        .toList();
    productionCountries = (json['production_countries'] as List? ?? [])
        .map((e) => ProductionCountry.fromJson(e))
        .toList();
    spokenLanguages = (json['spoken_languages'] as List? ?? [])
        .map((e) => SpokenLanguage.fromJson(e))
        .toList();
    status = json['status'] ?? '';
    tagline = json['tagline'];
    videos = (json['videos']?['results'] as List? ?? [])
        .map((e) => Video.fromJson(e))
        .toList();
  }
}
