import 'dart:async';

import 'package:domain/model/GeneralResult.dart';
import 'package:domain/model/MovieModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/MediaItem.dart';
import '../../../component/MoviePagerItem.dart';
import '../../../component/SimpleMediaItem.dart';
import 'movie_view_model.dart';

class MovieTab extends StatefulWidget {
  const MovieTab({super.key});

  @override
  State<MovieTab> createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  late final PageController _pageController;
  Timer? _timer;
  StreamSubscription? _timerSubscription;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MovieViewModel>();
      // ViewModel의 상태 변경을 감지하여 타이머를 제어합니다.
      _timerSubscription = viewModel.state.listen((state) {
        // 데이터가 성공적으로 로드되고 비어있지 않을 때 타이머를 시작합니다.
        if (!state.isLoading && state.movies?.$1.results.isNotEmpty == true) {
          _timer?.cancel(); // 기존 타이머가 있다면 취소합니다.
          _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
            if (!_pageController.hasClients) return;

            final pageCount = state.movies!.$1.results.length;
            if (pageCount == 0) return;
            final nextPage = (_pageController.page!.round() + 1) % pageCount;

            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          });
        } else {
          // 로딩 중이거나 에러가 발생하면 타이머를 중지합니다.
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<MovieState>(
          stream: viewModel.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error.toString()));
            }
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.movies == null) {
              return const Center(child: Text('No movies found'));
            }
            final (nowPlayingData, upcomingData, trendingData) = state.movies!;

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: trendingData.results.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListHeader(
                    pageController: _pageController,
                    nowPlayingData: nowPlayingData,
                    upcomingData: upcomingData,
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MediaItem(media: trendingData.results[index - 1]),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    _timerSubscription?.cancel();
    super.dispose();
  }
}

class ListHeader extends StatelessWidget {
  const ListHeader({
    super.key,
    required PageController pageController,
    required this.nowPlayingData,
    required this.upcomingData,
  }) : _pageController = pageController;

  final PageController _pageController;
  final GeneralResult<MovieModel> nowPlayingData;
  final GeneralResult<MovieModel> upcomingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            "Upcoming Movies",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return SimpleMediaItem(media: upcomingData.results[index]);
            },
            itemCount: upcomingData.results.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Trending Movies",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
