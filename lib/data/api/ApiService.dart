import 'package:dio/dio.dart';

import '../model/GeneralResult.dart';
import '../model/MovieModel.dart';
import 'DioClient.dart';

class ApiService {
  final Dio _dio = DioClient().dio; // DioClient를 통해 Dio 인스턴스 접근

  Future<GeneralResult<MovieModel>> getNowPlayingMovies() async {
    return _get<GeneralResult<MovieModel>>(
      path: '/movie/now_playing',
      queryParameters: {'language': 'ko-KR', 'page': "1", 'region': 'KR'},
      fromJson: (json) => GeneralResult.fromJson(json, (data) => MovieModel.fromJson(data as Map<String, dynamic>)),
    );
  }

  Future<T> _get<T>({
    required String path,
    required T Function(dynamic) fromJson,
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