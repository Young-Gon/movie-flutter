import '../model/GeneralResult.dart';
import '../model/MovieModel.dart';
import '../model/MovieDetail.dart';

abstract class MovieRepository {
  Future<GeneralResult<MovieModel>> getNowPlayingMovies();
  Future<GeneralResult<MovieModel>> getUpcomingMovies();
  Future<GeneralResult<MovieModel>> getTrendingMovie();
  Future<GeneralResult<MovieModel>> getSearch({required String query});
  Future<MovieDetailModel> getDetail({required int id});
}
