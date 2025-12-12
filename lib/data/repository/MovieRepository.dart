import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/MovieModel.dart';

class MovieRepository {
  final ApiService _apiService;

  MovieRepository(this._apiService);

  Future<GeneralResult<MovieModel>> getNowPlayingMovies() {
    return _apiService.getNowPlayingMovies();
  }
}
