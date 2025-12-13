import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/repository/MovieRepository.dart';

// ApiService를 제공하는 Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// MovieRepository를 제공하는 Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  // apiServiceProvider를 watch하여 ApiService 인스턴스를 가져옵니다.
  final apiService = ref.watch(apiServiceProvider);
  return MovieRepository(apiService);
});

// getNowPlayingMovies API의 결과를 제공하는 FutureProvider
final nowPlayingMoviesProvider = FutureProvider<GeneralResult<MovieModel>>((
  ref,
) async {
  // movieRepositoryProvider를 watch하여 MovieRepository 인스턴스를 가져옵니다.
  final movieRepository = ref.watch(movieRepositoryProvider);
  // 영화 데이터를 가져오는 API를 호출합니다.

  return await movieRepository.getNowPlayingMovies();
});
