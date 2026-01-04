import 'package:domain/model/MediaModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../util.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({super.key, required MediaModel media}) : _media = media;

  final MediaModel _media;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/details', extra: _media);
      },
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _media.posterPath != null
                ? Image.network(
                    Util.makeImgPath(_media.posterPath!),
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
                    _media.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    _media.releaseDate,
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
