import 'package:domain/model/GeneralResult.dart';
import 'package:domain/model/MovieModel.dart';
import 'package:domain/model/MovieDetail.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

import '../api/ApiService.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final ApiService _apiService;

  MovieRepositoryImpl(this._apiService);

  @override
  Future<GeneralResult<MovieModel>> getNowPlayingMovies() async {
    return await _apiService.getNowPlayingMovies();
  }

  @override
  Future<GeneralResult<MovieModel>> getUpcomingMovies() async {
    return await _apiService.getUpcomingMovies();
  }

  @override
  Future<GeneralResult<MovieModel>> getTrendingMovie() async {
    return await _apiService.getTrendingMovie();
  }

  @override
  Future<GeneralResult<MovieModel>> getSearch({required String query}) async {
    return await _apiService.getSearch(
      query: query,
      fromJson: (json) => MovieModel.fromJson(json),
    );
  }

  @override
  Future<MovieDetailModel> getDetail({required int id}) async {
    return await _apiService.getDetail(
      id: id,
      fromJson: (json) => MovieDetailModel.fromJson(json),
    );
  }
}
