import 'package:domain/model/GeneralResult.dart';
import 'package:domain/model/TVModel.dart';
import 'package:domain/model/tv_detail.dart';
import 'package:domain/repository/tv_repository.dart';
import 'package:injectable/injectable.dart';

import '../api/ApiService.dart';

@LazySingleton(as: TVRepository)
class TVRepositoryImpl implements TVRepository {
  final ApiService _apiService;

  TVRepositoryImpl(this._apiService);

  @override
  Future<GeneralResult<TVModel>> getTrendingTVs() async {
    return await _apiService.getTrendingTVs();
  }

  @override
  Future<GeneralResult<TVModel>> getAiringToday() async {
    return await _apiService.getAiringToday();
  }

  @override
  Future<GeneralResult<TVModel>> getTopRatedTVs() async {
    return await _apiService.getTopRatedTVs();
  }

  @override
  Future<GeneralResult<TVModel>> getSearch({required String query}) async {
    return await _apiService.getSearch(
      query: query,
      fromJson: (json) => TVModel.fromJson(json),
    );
  }

  @override
  Future<TVDetailModel> getDetail({required int id}) async {
    return await _apiService.getDetail(
      id: id,
      fromJson: (json) => TVDetailModel.fromJson(json),
    );
  }
}
