import 'dart:async';

import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
class TvViewModel {
  final TVRepository tvRepository;

  TvViewModel(this.tvRepository) {
    onIntent(GetTVs());
  }

  final _stateController = StreamController<TVState>.broadcast();

  Stream<TVState> get state => _stateController.stream;
  TVState _stateSnapShot = TVState();

  void onIntent(TVIntent intent) {
    if (intent is GetTVs) {
      fetchTVs();
    }
  }

  void updateState(TVState newState) {
    _stateSnapShot = newState;
    _stateController.add(newState);
  }

  Future<void> fetchTVs() async {
    updateState(_stateSnapShot.copyWith(isLoading: true));
    try {
      final results = await Future.wait([
        tvRepository.getTrendingTVs(),
        tvRepository.getAiringToday(),
        tvRepository.getTopRatedTVs(),
      ]);
      updateState(
        _stateSnapShot.copyWith(
          isLoading: false,
          tv: (results[0], results[1], results[2]),
        ),
      );
    } on Exception catch (e, s) {
      updateState(_stateSnapShot.copyWith(isLoading: false, error: e));
    }
  }

  void dispose() {
    _stateController.close();
  }
}

abstract class TVIntent {}

class GetTVs extends TVIntent {}

class TVState {
  final bool isLoading;
  final (
    GeneralResult<TVModel>,
    GeneralResult<TVModel>,
    GeneralResult<TVModel>,
  )?
  tv;
  final Exception? error;

  TVState({this.isLoading = false, this.tv, this.error});

  TVState copyWith({
    bool? isLoading,
    (GeneralResult<TVModel>, GeneralResult<TVModel>, GeneralResult<TVModel>)?
    tv,
    Exception? error,
  }) {
    return TVState(
      isLoading: isLoading ?? this.isLoading,
      tv: tv ?? this.tv,
      error: error ?? this.error,
    );
  }
}
