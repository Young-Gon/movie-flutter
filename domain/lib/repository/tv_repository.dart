import '../model/GeneralResult.dart';
import '../model/TVModel.dart';
import '../model/tv_detail.dart';

abstract class TVRepository {
  Future<GeneralResult<TVModel>> getTrendingTVs();
  Future<GeneralResult<TVModel>> getAiringToday();
  Future<GeneralResult<TVModel>> getTopRatedTVs();
  Future<GeneralResult<TVModel>> getSearch({required String query});
  Future<TVDetailModel> getDetail({required int id});
}
