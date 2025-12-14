// 5. 검색어를 위한 StateProvider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie/data/provider/tv_provider.dart';

import '../model/GeneralResult.dart';
import '../model/MovieModel.dart';
import '../model/TVModel.dart';
import 'movie_provider.dart';

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
