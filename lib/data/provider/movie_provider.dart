import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/repository/MovieRepository.dart';

// 1. ApiService Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// 2. MovieRepository Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  // apiServiceProvider를 사용하여 MovieRepository 인스턴스를 생성합니다.
  final apiService = ref.watch(apiServiceProvider);
  return MovieRepository(apiService);
});

// 4. 세 개의 API 결과를 통합하는 새로운 Provider
final moviePageDataProvider =
    FutureProvider<
      (
        GeneralResult<MovieModel>,
        GeneralResult<MovieModel>,
        GeneralResult<MovieModel>,
      )
    >((ref) async {
      final movieRepo = ref.watch(movieRepositoryProvider);

      // Future.wait를 사용하여 세 개의 API를 동시에 호출합니다.
      final results = await Future.wait([
        movieRepo.getNowPlayingMovies(),
        movieRepo.getUpcomingMovies(),
        movieRepo.getTrendingMovie(),
      ]);

      // 결과를 Record로 반환합니다.
      return (
        results[0], // nowPlaying
        results[1], // upcoming
        results[2], // trending
      );
    });
