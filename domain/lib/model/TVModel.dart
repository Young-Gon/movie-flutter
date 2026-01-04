// implements 대신 extends를 사용합니다.
import 'MediaModel.dart';

class TVModel extends MediaModel {
  final String firstAirDate;
  final String name;
  final List<String> originCountry;
  final String originalName;

  // MediaModel의 getter들을 구현합니다.
  @override
  String get title => name;

  @override
  String get releaseDate => firstAirDate;

  TVModel.fromJson(super.json)
    : name = json['name'] ?? '',
      firstAirDate = json['first_air_date'] ?? '',
      originCountry = List<String>.from(json['origin_country'] ?? []),
      originalName = json['original_name'] ?? '',
      super.fromJson();
}
