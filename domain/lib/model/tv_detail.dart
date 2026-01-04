import 'MediaDetail.dart';
import 'TVModel.dart';

class Creator {
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String? profilePath;

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    this.profilePath,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'] ?? 0,
      creditId: json['credit_id'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? 0,
      profilePath: json['profile_path'],
    );
  }
}

class Episode {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? airDate;
  final int episodeNumber;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    required this.episodeNumber,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      airDate: json['air_date'],
      episodeNumber: json['episode_number'] ?? 0,
      productionCode: json['production_code'] ?? '',
      runtime: json['runtime'],
      seasonNumber: json['season_number'] ?? 0,
      showId: json['show_id'] ?? 0,
      stillPath: json['still_path'],
    );
  }
}

class Network {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  Network({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'] ?? 0,
      logoPath: json['logo_path'],
      name: json['name'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }
}

class Season {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'],
      episodeCount: json['episode_count'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'] ?? 0,
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
    );
  }
}

// TVModel을 상속하고 MediaDetailMixin을 with합니다.
class TVDetailModel extends TVModel with MediaDetailMixin {
  final List<Creator> createdBy;
  final List<int> episodeRunTime;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final Episode? nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;
  final String type;

  TVDetailModel.fromJson(Map<String, dynamic> json)
    // 1. TVDetailModel의 고유 필드 파싱
    : createdBy = (json['created_by'] as List? ?? [])
          .map((e) => Creator.fromJson(e))
          .toList(),
      episodeRunTime = List<int>.from(json['episode_run_time'] ?? []),
      inProduction = json['in_production'] ?? false,
      languages = List<String>.from(json['languages'] ?? []),
      lastAirDate = json['last_air_date'],
      lastEpisodeToAir = json['last_episode_to_air'] != null
          ? Episode.fromJson(json['last_episode_to_air'])
          : null,
      nextEpisodeToAir = json['next_episode_to_air'] != null
          ? Episode.fromJson(json['next_episode_to_air'])
          : null,
      networks = (json['networks'] as List? ?? [])
          .map((e) => Network.fromJson(e))
          .toList(),
      numberOfEpisodes = json['number_of_episodes'] ?? 0,
      numberOfSeasons = json['number_of_seasons'] ?? 0,
      seasons = (json['seasons'] as List? ?? [])
          .map((e) => Season.fromJson(e))
          .toList(),
      type = json['type'] ?? '',
      // 2. 부모 TVModel의 fromJson 호출
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
