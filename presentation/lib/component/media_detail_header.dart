import 'dart:ui';

import 'package:domain/model/MediaModel.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class MediaDetailHeader extends StatelessWidget {
  const MediaDetailHeader({
    super.key,
    required MediaModel movie,
    required this.children,
  }) : _movie = movie;

  final MediaModel _movie;
  final List<Widget> children;

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
        Padding(
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
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
