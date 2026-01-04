import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/component/ErrorScreen.dart';
import 'package:movie/data/provider/tv_provider.dart';

import '../../../component/SimpleMediaItem.dart';

class TvPage extends ConsumerWidget {
  const TvPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 통합된 tvPageDataProvider를 watch합니다.
    final allTVsAsyncValue = ref.watch(tvPageDataProvider);

    return allTVsAsyncValue.when(
      data: (allTVs) {
        // Record에서 각 API의 결과를 추출합니다.
        final trendingData = allTVs.$1;
        final airingTodayData = allTVs.$2;
        final topRatedData = allTVs.$3;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Trending TV Shows",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemCount: trendingData.results.length,
                  itemBuilder: (context, index) {
                    return SimpleMediaItem(media: trendingData.results[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Airing Today",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemCount: trendingData.results.length,
                  itemBuilder: (context, index) {
                    return SimpleMediaItem(
                      media: airingTodayData.results[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Top Rated TV Shows",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemCount: trendingData.results.length,
                  itemBuilder: (context, index) {
                    return SimpleMediaItem(media: topRatedData.results[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        print('TV 페이지 에러 발생: $error');
        return const ErrorScreen();
      },
    );
  }
}
