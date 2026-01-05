import 'dart:async';

import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchViewModel {
  final MovieRepository movieRepository;
  final TVRepository tvRepository;

  SearchViewModel(this.movieRepository, this.tvRepository);

  final _stateController = StreamController<SearchState>();

  Stream<SearchState> get state => _stateController.stream;
  SearchState _stateSnapShot = SearchState();

  void onIntent(SearchIntent intent) {
    switch (intent) {
      case Search():
        search(intent.query, _stateSnapShot.mediaType);
        break;
      case SetMediaType():
        search(_stateSnapShot.query, intent.mediaType);
        break;
    }
  }

  void updateState(SearchState newState) {
    _stateSnapShot = newState;
    _stateController.add(newState);
  }

  Future<void> search(String query, MediaType mediaType) async {
    updateState(
      _stateSnapShot.copyWith(
        isLoading: true,
        query: query,
        mediaType: mediaType,
      ),
    );
    try {
      final result = (mediaType == MediaType.movie)
          ? await movieRepository.getSearch(query: query)
          : await tvRepository.getSearch(query: query);
      updateState(
        _stateSnapShot.copyWith(isLoading: false, results: result.results),
      );
    } on Exception catch (e, s) {
      updateState(_stateSnapShot.copyWith(isLoading: false, error: e));
    }
  }

  void dispose() {
    _stateController.close();
  }
}

sealed class SearchIntent {}

class Search extends SearchIntent {
  final String query;

  Search(this.query);
}

class SetMediaType extends SearchIntent {
  final MediaType mediaType;

  SetMediaType(this.mediaType);
}

enum MediaType { movie, tv }

class SearchState {
  final bool isLoading;
  final Exception? error;
  final MediaType mediaType;
  final String query;
  final List<MediaModel> results;

  SearchState({
    this.isLoading = false,
    this.error,
    this.mediaType = MediaType.movie,
    this.query = '',
    this.results = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    Exception? error,
    MediaType? mediaType,
    String? query,
    List<MediaModel>? results,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      mediaType: mediaType ?? this.mediaType,
      query: query ?? this.query,
      results: results ?? this.results,
    );
  }
}
