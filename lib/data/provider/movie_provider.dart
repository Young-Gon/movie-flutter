import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/model/TVModel.dart';
import 'package:movie/data/provider/tv_provider.dart';
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

// 3. 기존 Provider들 (개별 사용 가능)
final nowPlayingMoviesProvider = FutureProvider((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getNowPlayingMovies();
});

final upcomingMoviesProvider = FutureProvider((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getUpcomingMovies();
});

final trendingMovieProvider = FutureProvider((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getTrendingMovie();
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

// 5. 검색어를 위한 StateProvider
final searchQueryProvider = StateProvider<String>((ref) => '');

// 6. 영화와 TV 검색 결과를 통합하는 FutureProvider
final searchProvider =
    FutureProvider<(GeneralResult<MovieModel>, GeneralResult<TVModel>)>((
      ref,
    ) async {
      // 검색어 Provider를 watch합니다.
      final query = ref.watch(searchQueryProvider);

      // 검색어가 비어있으면 API를 호출하지 않고 빈 결과를 반환합니다.
      if (query.isEmpty) {
        throw Exception('검색어가 비어있습니다.');
      }

      final movieRepo = ref.watch(movieRepositoryProvider);
      final tvRepo = ref.watch(tvRepositoryProvider);

      final results = await Future.wait([
        movieRepo.getSearch(query: query),
        tvRepo.getSearch(query: query),
      ]);

      return (
        results[0] as GeneralResult<MovieModel>,
        results[1] as GeneralResult<TVModel>,
      );
    });
