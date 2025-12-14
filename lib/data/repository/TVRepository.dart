import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/TVModel.dart';

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
}
