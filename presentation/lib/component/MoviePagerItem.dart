import 'package:domain/model/MovieModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'media_detail_header.dart';

class MoviePagerItem extends StatelessWidget {
  const MoviePagerItem({super.key, required MovieModel movie}) : _movie = movie;

  final MovieModel _movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/details', extra: _movie);
      },
      child: MediaDetailHeader(
        movie: _movie,
        children: [
          Text(_movie.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(
            _movie.releaseDate,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            _movie.overview,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
