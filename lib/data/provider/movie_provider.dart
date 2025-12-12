import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/api/ApiService.dart';
import 'package:movie/data/model/MovieModel.dart';

import '../model/GeneralResult.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final nowPlayingMoviesProvider = FutureProvider<GeneralResult<MovieModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getNowPlayingMovies();
});
