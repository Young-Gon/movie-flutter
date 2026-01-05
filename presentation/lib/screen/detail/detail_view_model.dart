import 'dart:async';

import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailViewModel {
  final MovieRepository movieRepository;
  final TVRepository tvRepository;

  DetailViewModel(
    this.movieRepository,
    this.tvRepository,
    @factoryParam MediaModel initalMedia,
  ) {
    onIntent(InitMedia(initalMedia));
  }

  final _stateController = StreamController<DetailState>();

  Stream<DetailState> get state => _stateController.stream;
  DetailState _stateSnapShot = DetailState();

  void onIntent(DetailIntent intent) {
    switch (intent) {
      case InitMedia():
        _updateState(_stateSnapShot.copyWith(media: intent.media));
        _fetchDetail(intent.media);
        break;
    }
  }

  void _updateState(DetailState newState) {
    _stateSnapShot = newState;
    _stateController.add(newState);
  }

  Future<void> _fetchDetail(MediaModel media) async {
    _updateState(_stateSnapShot.copyWith(isLoading: true));
    try {
      final MediaModel detailData;
      if (media is MovieModel) {
        detailData = await movieRepository.getDetail(id: media.id);
      } else if (media is TVModel) {
        detailData = await tvRepository.getDetail(id: media.id);
      } else {
        throw UnimplementedError(
          'Detail view not implemented for this media type: ${media.runtimeType}',
        );
      }
      _updateState(
        _stateSnapShot.copyWith(media: detailData, isLoading: false),
      );
    } on Exception catch (e, s) {
      _updateState(_stateSnapShot.copyWith(error: e, isLoading: false));
    }
  }

  void dispose() {
    _stateController.close();
  }
}

sealed class DetailIntent {}

class InitMedia extends DetailIntent {
  final MediaModel media;

  InitMedia(this.media);
}

class DetailState {
  final bool isLoading;
  final Exception? error;
  final MediaModel? media;

  DetailState({this.isLoading = false, this.error, this.media});

  DetailState copyWith({bool? isLoading, Exception? error, MediaModel? media}) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      media: media ?? this.media,
    );
  }
}
