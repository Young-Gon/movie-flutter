import 'package:domain/model/MediaModel.dart';
import 'package:flutter/cupertino.dart';

class DetailScreen extends StatelessWidget {
  final MediaModel _media;

  const DetailScreen({super.key, required MediaModel media}) : _media = media;

  @override
  Widget build(BuildContext context) {
    return const Text('Detail');
  }
}
