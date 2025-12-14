import 'package:flutter/material.dart';
import 'package:movie/component/media_detail_header.dart';
import 'package:movie/data/model/MovieModel.dart';

import '../screens/detail/detail_screen.dart';

class MoviePagerItem extends StatelessWidget {
  const MoviePagerItem({super.key, required MovieModel movie}) : _movie = movie;

  final MovieModel _movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("MoviePagerItem clicked!!");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailScreen(media: _movie)),
        );
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
