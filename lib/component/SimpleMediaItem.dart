import 'package:flutter/material.dart';

import '../data/model/MediaModel.dart';
import '../screens/detail/detail_screen.dart';
import '../util.dart';

class SimpleMediaItem extends StatelessWidget {
  const SimpleMediaItem({super.key, required MediaModel media})
    : _media = media;

  final MediaModel _media;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailScreen(media: _media)),
        );
      },
      child: SizedBox(
        width: 100,
        child: Column(
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
            Text(
              _media.title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              _media.releaseDate,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
