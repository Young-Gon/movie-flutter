import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/provider/movie_provider.dart';

class MoviePage extends ConsumerWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // nowPlayingMoviesProvider를 감시하고 상태에 따라 UI를 업데이트합니다.
    final moviesAsyncValue = ref.watch(nowPlayingMoviesProvider);

    // AsyncValue의 when 메소드를 사용하여 로딩, 에러, 데이터 상태를 처리합니다.
    return moviesAsyncValue.when(
      data: (data) {
        // 데이터 로딩 성공 시 콘솔에 수신된 영화 개수를 출력합니다.
        print('성공적으로 영화 데이터를 수신했습니다. 영화 개수: ${data.results.length}');
        // UI 레이아웃은 변경하지 말라는 요청에 따라 Placeholder를 반환합니다.
        return const Placeholder();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        // 에러 발생 시 콘솔에 에러를 출력합니다.
        print('에러 발생: $error');
        return Center(child: Text('데이터를 불러오는 데 실패했습니다: $error'));
      },
    );
  }
}
