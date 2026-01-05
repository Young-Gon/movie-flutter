import 'package:domain/model/MediaDetail.dart';
import 'package:domain/model/MediaModel.dart';
import 'package:domain/model/MovieModel.dart';
import 'package:domain/model/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/ErrorScreen.dart';
import '../../component/media_detail_header.dart';
import 'detail_view_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<DetailState>(
          stream: viewModel.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final _media = state.media;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  _media is MovieModel ? 'Movie' : 'TV',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: _buildResult(context, state.error != null, _media!),
            );
          },
        );
      },
    );
  }

  Widget _buildResult(
    BuildContext context,
    bool isError,
    MediaModel detailData,
  ) {
    if (isError) {
      return ErrorScreen();
    }
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
                Text("씨놉시스", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  detailData.overview,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                if (mixinDetail?.videos.isNotEmpty == true)
                  for (final video in mixinDetail!.videos)
                    if (video.site == "YouTube" && video.type == "Trailer")
                      trailerIcon(video, context),
              ],
            ),
          ),
        ],
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
