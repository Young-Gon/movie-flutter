import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/MovieModel.dart';

class MovieRepository {
  final ApiService _apiService;

  MovieRepository(this._apiService);

  Future<GeneralResult<MovieModel>> getNowPlayingMovies() async {
    return await _apiService.getNowPlayingMovies();
  }

  Future<GeneralResult<MovieModel>> getUpcomingMovies() async {
    return await _apiService.getUpcomingMovies();
  }

  Future<GeneralResult<MovieModel>> getTrendingMovie() async {
    return await _apiService.getTrendingMovie();
  }

  Future<GeneralResult<MovieModel>> getSearch({required String query}) async {
    return await _apiService.getSearch(
      query: query,
      fromJson: (json) => MovieModel.fromJson(json),
    );
  }
}
