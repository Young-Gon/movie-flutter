import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/util.dart';

class MoviePagerItem extends StatelessWidget {
  const MoviePagerItem({super.key, required MovieModel movie}) : _movie = movie;

  final MovieModel _movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _movie.backdropPath != null
            ? Image.network(
                Util.makeImgPath(_movie.backdropPath!),
                height: 250,
                fit: BoxFit.fitWidth,
              )
            : Container(color: Colors.grey, height: 250),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/movie', arguments: _movie);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _movie.posterPath != null
                    ? Image.network(
                        Util.makeImgPath(_movie.posterPath!),
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(width: 100, height: 150, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _movie.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
