import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/component/ErrorScreen.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/model/tv_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/media_detail_header.dart';
import '../../data/model/MediaDetail.dart';
import '../../data/model/MediaModel.dart';
import '../../data/provider/detail_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required MediaModel media}) : _media = media;

  final MediaModel _media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // detailNotifierProvider를 사용하여 상태를 watch합니다.
    final detailAsyncValue = ref.watch(detailNotifierProvider(_media));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _media is MovieModel ? 'Movie' : 'TV',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: detailAsyncValue.when(
        data: (detailData) {
          // 처음에는 _media 데이터가 표시되고, API 호출 완료 후
          // MovieDetail 또는 TVDetail 데이터로 화면이 업데이트됩니다.
          final MediaDetailMixin? mixinDetail = detailData is MediaDetailMixin
              ? (detailData as MediaDetailMixin)
              : null;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: MediaDetailHeader(
                    movie: detailData,
                    children: [
                      Text(
                        detailData.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        (mixinDetail?.productionCompanies.isNotEmpty == true)
                            ? "${mixinDetail!.productionCompanies[0]}${(mixinDetail.productionCompanies.length > 1) ? " 외 ${mixinDetail.productionCompanies.length}개" : ""}"
                            : "",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        mixinDetail?.genres.isNotEmpty == true
                            ? mixinDetail!.genres
                                  .map((genre) => genre.name)
                                  .join(', ')
                            : "",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        detailData is TVDetailModel
                            ? "${detailData.seasons.length} season${detailData.seasons.length > 1 ? "s" : ""}"
                            : "",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${detailData.releaseDate} ⭐ ${detailData.voteAverage.toStringAsFixed(1)}",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "씨놉시스",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        detailData.overview,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      if (mixinDetail?.videos.isNotEmpty == true)
                        for (final video in mixinDetail!.videos)
                          if (video.site == "YouTube" &&
                              video.type == "Trailer")
                            trailerIcon(video, context),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        // 초기 로딩 상태는 건너뛰지만, 백그라운드에서 에러가 발생할 경우를 위해
        // loading과 error 상태는 그대로 둡니다.
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          print('상세 페이지 에러 발생: $error');
          return const ErrorScreen();
        },
      ),
    );
  }

  GestureDetector trailerIcon(Video video, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse('https://www.youtube.com/watch?v=${video.key}');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          // 유튜브 앱으로 열 수 없으면 웹 브라우저로 시도
          if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not launch YouTube video.'),
                ),
              );
            }
          }
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_arrow),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              video.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
