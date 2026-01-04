// data/lib/src/di/network_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const API_KEY =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhY2UzM2QxNGEwNDJkNTRiMjRjZWZiNDdjM2E2NWZkOCIsIm5iZiI6MTc2NDIwMzIwMy40NDUsInN1YiI6IjY5Mjc5YWMzYWI1NWRhZjhkZDM3MTk0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gPZAgokhB0XbPs-7GvI_YJoBfhtw95F6aOitmsOdi-8";

@module
abstract class NetworkModule {
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        // API 서버의 기본 URL (필수 설정)
        baseUrl: 'https://api.themoviedb.org/3',
        // 연결 타임아웃 (예: 5초)
        connectTimeout: const Duration(seconds: 5),
        // 데이터 수신 타임아웃 (예: 30초)
        receiveTimeout: const Duration(seconds: 30),
        // 기본 Content Type 설정
        contentType: 'application/json; charset=utf-8',
        headers: {'Authorization': 'Bearer $API_KEY'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
