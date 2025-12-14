import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/TVModel.dart';

import '../model/tv_detail.dart';

class TVRepository {
  final ApiService _apiService;

  TVRepository(this._apiService);

  Future<GeneralResult<TVModel>> getTrendingTVs() async {
    return await _apiService.getTrendingTVs();
  }

  Future<GeneralResult<TVModel>> getAiringToday() async {
    return await _apiService.getAiringToday();
  }

  Future<GeneralResult<TVModel>> getTopRatedTVs() async {
    return await _apiService.getTopRatedTVs();
  }

  Future<GeneralResult<TVModel>> getSearch({required String query}) async {
    return await _apiService.getSearch(
      query: query,
      fromJson: (json) => TVModel.fromJson(json),
    );
  }

  Future<TVDetailModel> getDetail({required int id}) async {
    return await _apiService.getDetail(
      id: id,
      fromJson: (json) => TVDetailModel.fromJson(json),
    );
  }
}
