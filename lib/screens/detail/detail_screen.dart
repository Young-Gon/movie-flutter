import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/component/ErrorScreen.dart';
import 'package:movie/data/provider/detail_provider.dart';

import '../../data/model/MediaModel.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required MediaModel media}) : _media = media;

  final MediaModel _media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // detailProvider.family에 _media 객체를 파라미터로 전달합니다.
    final detailAsyncValue = ref.watch(detailProvider(_media));

    return Scaffold(
      body: detailAsyncValue.when(
        data: (detailData) {
          // TODO: detailData를 사용하여 상세 페이지 UI를 구성합니다.
          return const Center(child: Text("Detail Data Loaded!"));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          print('상세 페이지 에러 발생: $error');
          return const ErrorScreen();
        },
      ),
    );
  }
}
