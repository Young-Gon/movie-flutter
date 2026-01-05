import 'package:domain/model/MovieModel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_movie_data.dart';

void main() {
  group('MovieModel', () {
    test('fromJson은 JSON 맵에서 MovieModel 객체를 생성해야 한다', () {
      // Mock 데이터를 사용하여 MovieModel.fromJson을 호출합니다.
      final movie = MovieModel.fromJson(mockMovieJson);

      // 생성된 객체의 각 필드가 Mock 데이터의 값과 일치하는지 확인합니다.
      expect(movie.id, 786892);
      expect(movie.title, "퓨리오사: 매드맥스 사가");
      expect(
        movie.overview,
        "세상이 멸망하고 45년, 인류는 황폐해진 세상에 익숙해졌다. 녹색의 땅을 찾아 헤매던 그녀, '퓨리오사'는 바이커 군단의 폭군 '디멘투스'의 손에 모든 것을 잃고 만다. 가족도, 행복도, 희망도 없이 세상에 홀로 내던져진 '퓨리오사'는 복수를 위해 자신의 모든 것을 걸기로 결심하는데... 매드맥스 없는 매드맥스, 분노의 도로 그 이전, 퓨리오사의 과거가 깨어난다!",
      );
      expect(movie.posterPath, "/9p36wYcstC9B2iS2m3a223O5y19.jpg");
      expect(movie.releaseDate, "2024-05-22");
      expect(movie.voteAverage, 7.7);
      expect(movie.genreIds, containsAll([28, 12, 878]));
    });
  });
}
