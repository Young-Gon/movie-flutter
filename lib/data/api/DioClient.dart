import 'package:dio/dio.dart';

const API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhY2UzM2QxNGEwNDJkNTRiMjRjZWZiNDdjM2E2NWZkOCIsIm5iZiI6MTc2NDIwMzIwMy40NDUsInN1YiI6IjY5Mjc5YWMzYWI1NWRhZjhkZDM3MTk0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gPZAgokhB0XbPs-7GvI_YJoBfhtw95F6aOitmsOdi-8";

class DioClient {
  // 1. 싱글턴 인스턴스
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  // 2. 실제 Dio 객체
  late Dio dio;

  // 3. 내부 생성자에서 기본 설정
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        // API 서버의 기본 URL (필수 설정)
        baseUrl: 'https://api.themoviedb.org/3',
        // 연결 타임아웃 (예: 5초)
        connectTimeout: const Duration(seconds: 5),
        // 데이터 수신 타임아웃 (예: 30초)
        receiveTimeout: const Duration(seconds: 30),
        // 기본 Content Type 설정
        contentType: 'application/json; charset=utf-8',
        headers: {
          'Authorization': 'Bearer $API_KEY',
        }
      ),
    );
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

  }
}
