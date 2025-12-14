import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie/data/model/MediaModel.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/model/TVModel.dart';
import 'package:movie/data/provider/movie_provider.dart';
import 'package:movie/data/provider/tv_provider.dart';

// 1. StateNotifier 클래스를 정의합니다.
class DetailNotifier extends StateNotifier<AsyncValue<MediaModel>> {
  // 생성자에서 ref와 초기 데이터(placeholder)를 받습니다.
  DetailNotifier(this.ref, MediaModel placeholderData)
    : super(AsyncValue.data(placeholderData)) {
    // placeholder로 초기 상태 설정
    // 생성자가 호출될 때 백그라운드에서 전체 데이터 fetch를 시작합니다.
    _fetchDetail(placeholderData);
  }

  final Ref ref;

  Future<void> _fetchDetail(MediaModel media) async {
    try {
      final MediaModel detailData;
      if (media is MovieModel) {
        final repository = ref.read(movieRepositoryProvider);
        detailData = await repository.getDetail(id: media.id);
      } else if (media is TVModel) {
        final repository = ref.read(tvRepositoryProvider);
        detailData = await repository.getDetail(id: media.id);
      } else {
        throw UnimplementedError(
          'Detail view not implemented for this media type: ${media.runtimeType}',
        );
      }
      // 데이터를 성공적으로 가져오면 state를 업데이트합니다.
      state = AsyncValue.data(detailData);
    } catch (e, s) {
      // 에러 발생 시 state를 업데이트합니다.
      state = AsyncValue.error(e, s);
    }
  }
}

// 2. StateNotifierProvider.family를 생성합니다.
final detailNotifierProvider =
    StateNotifierProvider.family<
      DetailNotifier,
      AsyncValue<MediaModel>,
      MediaModel
    >((ref, media) {
      // family의 파라미터(media)를 Notifier의 생성자로 전달합니다.
      return DetailNotifier(ref, media);
    });
