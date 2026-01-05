import 'package:flutter/material.dart';
import 'package:presentation/screen/home/tabs/tv_view_model.dart';
import 'package:provider/provider.dart';

import '../../../component/SimpleMediaItem.dart';

class TvTab extends StatelessWidget {
  const TvTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TvViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<TVState>(
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
            if (state.tv == null) {
              return const Center(child: Text('No TV shows found'));
            }
            final (trendingData, airingTodayData, topRatedData) = state.tv!;

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
                        return SimpleMediaItem(
                          media: trendingData.results[index],
                        );
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
                        return SimpleMediaItem(
                          media: topRatedData.results[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
