import 'package:dio/dio.dart';
import 'package:movie/data/model/TVModel.dart';

import '../model/GeneralResult.dart';
import '../model/MediaModel.dart';
import '../model/MovieModel.dart';
import 'DioClient.dart';

class ApiService {
  final Dio _dio = DioClient().dio; // DioClient를 통해 Dio 인스턴스 접근

  Future<GeneralResult<MovieModel>> getNowPlayingMovies() async {
    return await _get<GeneralResult<MovieModel>>(
      path: '/movie/now_playing',
      queryParameters: {'language': 'ko-KR', 'page': "1", 'region': 'KR'},
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return MovieModel.fromJson(data);
      }),
    );
  }

  Future<GeneralResult<MovieModel>> getUpcomingMovies() async {
    return await _get(
      path: '/movie/upcoming',
      queryParameters: {'language': 'ko-KR', 'page': "1", 'region': 'KR'},
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return MovieModel.fromJson(data);
      }),
    );
  }

  Future<GeneralResult<MovieModel>> getTrendingMovie() async {
    return await _get(
      path: '/trending/movie/week',
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return MovieModel.fromJson(data);
      }),
    );
  }

  Future<GeneralResult<R>> getSearch<R extends MediaModel>({
    required String query,
    required R Function(dynamic) fromJson,
  }) async {
    return await _get(
      // 타입을 비교할 때는 '==' 연산자를 사용합니다.
      path: '/search/${R == TVModel ? 'tv' : 'movie'}',
      queryParameters: {'query': query, 'language': 'ko-KR', 'page': "1"},
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return fromJson(data);
      }),
    );
  }

  Future<GeneralResult<TVModel>> getTrendingTVs() async {
    return await _get(
      path: '/trending/tv/week',
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return TVModel.fromJson(data);
      }),
    );
  }

  Future<GeneralResult<TVModel>> getAiringToday() async {
    return await _get(
      path: '/tv/airing_today',
      queryParameters: {'language': 'ko-KR', 'page': "1", 'timezone': 'KR'},
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return TVModel.fromJson(data);
      }),
    );
  }

  Future<GeneralResult<TVModel>> getTopRatedTVs() async {
    return await _get(
      path: '/tv/popular',
      queryParameters: {'language': 'ko-KR', 'page': "1", 'region': 'KR'},
      fromJson: (json) => GeneralResult.fromJson(json, (data) {
        return TVModel.fromJson(data);
      }),
    );
  }

  Future<R> _get<R>({
    required String path,
    required R Function(dynamic) fromJson,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return fromJson(response.data);
    } on DioException catch (e) {
      // DioException 처리
      throw Exception('Failed to load data: ${e.message}');
    } catch (e) {
      // 기타 예외 처리
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
