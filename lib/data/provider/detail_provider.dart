import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/model/MediaModel.dart';
import 'package:movie/data/model/MovieModel.dart';
import 'package:movie/data/model/TVModel.dart';
import 'package:movie/data/provider/movie_provider.dart';
import 'package:movie/data/provider/tv_provider.dart';

// FutureProvider.family를 사용하여 UI로부터 media 객체를 파라미터로 전달받습니다.
final detailProvider = FutureProvider.family<MediaModel, MediaModel>((
  ref,
  media,
) async {
  // media 객체의 런타임 타입을 확인합니다.
  if (media is MovieModel) {
    // MovieModel이면 MovieRepository를 사용하여 영화 상세 정보를 가져옵니다.
    final repository = ref.watch(movieRepositoryProvider);
    return await repository.getDetail(id: media.id);
  } else if (media is TVModel) {
    // TVModel이면 TVRepository를 사용하여 TV 상세 정보를 가져옵니다.
    final repository = ref.watch(tvRepositoryProvider);
    return await repository.getDetail(id: media.id);
  }

  // 예외 처리: 지원되지 않는 타입일 경우 에러를 발생시킵니다.
  throw UnimplementedError(
    'Detail view not implemented for this media type: ${media.runtimeType}',
  );
});
