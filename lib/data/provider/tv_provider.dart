import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/model/GeneralResult.dart';
import 'package:movie/data/model/TVModel.dart';
import 'package:movie/data/provider/movie_provider.dart';
import 'package:movie/data/repository/TVRepository.dart';

// 1. TVRepository Provider
final tvRepositoryProvider = Provider<TVRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TVRepository(apiService);
});

// 2. 세 가지 TV API 결과를 통합하는 새로운 Provider
final tvPageDataProvider =
    FutureProvider<
      (GeneralResult<TVModel>, GeneralResult<TVModel>, GeneralResult<TVModel>)
    >((ref) async {
      final tvRepo = ref.watch(tvRepositoryProvider);

      // Future.wait를 사용하여 세 개의 API를 동시에 호출합니다.
      final results = await Future.wait([
        tvRepo.getTrendingTVs(),
        tvRepo.getAiringToday(),
        tvRepo.getTopRatedTVs(),
      ]);

      // 결과를 Record로 반환합니다.
      return (
        results[0], // trending
        results[1], // airing today
        results[2], // top rated
      );
    });
