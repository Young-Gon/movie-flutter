import 'package:movie/data/model/MovieModel.dart';

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      logoPath: json['logo_path'],
      name: json['name'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SpokenLanguage {
  final String iso6391;
  final String name;

  SpokenLanguage({required this.iso6391, required this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Video {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  Video({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      iso6391: json['iso_639_1'] ?? '',
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
      key: json['key'] ?? '',
      site: json['site'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
      official: json['official'] ?? false,
      publishedAt: json['published_at'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class MovieDetailModel extends MovieModel {
  final Map<String, dynamic>? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final String? imdbId;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final List<Video> videos;

  MovieDetailModel.fromJson(super.json)
    : belongsToCollection = json['belongs_to_collection'],
      budget = json['budget'] ?? 0,
      genres = (json['genres'] as List? ?? [])
          .map((e) => Genre.fromJson(e))
          .toList(),
      homepage = json['homepage'],
      imdbId = json['imdb_id'],
      productionCompanies = (json['production_companies'] as List? ?? [])
          .map((e) => ProductionCompany.fromJson(e))
          .toList(),
      productionCountries = (json['production_countries'] as List? ?? [])
          .map((e) => ProductionCountry.fromJson(e))
          .toList(),
      revenue = json['revenue'] ?? 0,
      runtime = json['runtime'],
      spokenLanguages = (json['spoken_languages'] as List? ?? [])
          .map((e) => SpokenLanguage.fromJson(e))
          .toList(),
      status = json['status'] ?? '',
      tagline = json['tagline'],
      videos = (json['videos']?['results'] as List? ?? [])
          .map((e) => Video.fromJson(e))
          .toList(),
      super.fromJson();
}
