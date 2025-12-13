import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/ErrorScreen.dart';
import '../../../component/MoviePagerItem.dart';
import '../../../data/provider/movie_provider.dart';

class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({super.key});

  @override
  ConsumerState<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  late final PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moviesAsyncValue = ref.watch(nowPlayingMoviesProvider);

    // 데이터 로딩 상태를 감지하여 타이머를 설정합니다.
    ref.listen(nowPlayingMoviesProvider, (_, state) {
      if (state.hasValue && state.value!.results.isNotEmpty) {
        _timer?.cancel(); // 기존 타이머가 있다면 취소합니다.
        _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
          if (!_pageController.hasClients) return;

          final pageCount = state.value!.results.length;
          final nextPage = (_pageController.page!.round() + 1) % pageCount;

          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        });
      }
    });

    return moviesAsyncValue.when(
      data: (data) {
        print('성공적으로 영화 데이터를 수신했습니다. 영화 개수: ${data.results.length}');
        return SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              return MoviePagerItem(movie: data.results[index]);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        print('에러 발생: $error');
        _timer?.cancel(); // 에러 발생 시 타이머를 중지합니다.
        return ErrorScreen();
      },
    );
  }
}
