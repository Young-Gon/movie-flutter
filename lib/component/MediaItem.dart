import 'package:flutter/material.dart';

import '../data/model/MovieModel.dart';
import '../util.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({super.key, required MovieModel movie}) : _movie = movie;

  final MovieModel _movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/movie', arguments: _movie);
      },
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _movie.posterPath != null
                ? Image.network(
                    Util.makeImgPath(_movie.posterPath!),
                    width: 100,
                    height: 160,
                    fit: BoxFit.cover,
                  )
                : Container(width: 100, height: 160, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _movie.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    _movie.releaseDate,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
