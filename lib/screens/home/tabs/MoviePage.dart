import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/component/SimpleMediaItem.dart';

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
    // 통합된 moviePageDataProvider를 watch합니다.
    final allMoviesAsyncValue = ref.watch(moviePageDataProvider);

    // 데이터 로딩 상태를 감지하여 타이머를 설정합니다.
    ref.listen(moviePageDataProvider, (_, state) {
      if (state.hasValue && state.value!.$1.results.isNotEmpty) {
        _timer?.cancel(); // 기존 타이머가 있다면 취소합니다.
        _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
          if (!_pageController.hasClients) return;

          final pageCount = state.value!.$1.results.length;
          final nextPage = (_pageController.page!.round() + 1) % pageCount;

          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        });
      }
    });

    return allMoviesAsyncValue.when(
      data: (allMovies) {
        // Record에서 각 API의 결과를 추출합니다.
        final nowPlayingData = allMovies.$1;
        final upcomingData = allMovies.$2;
        final trendingData = allMovies.$3;

        // 화면 전체를 스크롤할 수 있도록 SingleChildScrollView로 감싸줍니다.
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now Playing Movies",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: nowPlayingData.results.length,
                  itemBuilder: (context, index) {
                    return MoviePagerItem(movie: nowPlayingData.results[index]);
                  },
                ),
              ),
              Text(
                "Upcomming Movies",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    return SimpleMediaItem(movie: upcomingData.results[index]);
                  },
                  itemCount: upcomingData.results.length,
                ),
              ),
              Text(
                "Trending Movies",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
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
