// presentation/lib/screen/home/tabs/movie_view_model.dart
import 'dart:async';

import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
class MovieViewModel {
  MovieViewModel(this._movieRepository, this._tvRepository) {
    onIntent(GetMovies());
  }

  final MovieRepository _movieRepository;
  final TVRepository _tvRepository;
  final _stateController = StreamController<MovieState>();

  Stream<MovieState> get state => _stateController.stream;
  MovieState _stateSnapShot = MovieState();

  void onIntent(MovieIntent intent) {
    if (intent is GetMovies) {
      fetchMovies();
    }
  }

  void _updateState(MovieState newState) {
    _stateSnapShot = newState;
    _stateController.add(newState);
  }

  Future<void> fetchMovies() async {
    _updateState(_stateSnapShot.copyWith(isLoading: true));
    try {
      final results = await Future.wait([
        _movieRepository.getTrendingMovie(),
        _movieRepository.getNowPlayingMovies(),
        _movieRepository.getUpcomingMovies(),
      ]);
      _updateState(
        _stateSnapShot.copyWith(
          isLoading: false,
          movies: (results[0], results[1], results[2]),
        ),
      );
    } on Exception catch (e, s) {
      _updateState(_stateSnapShot.copyWith(isLoading: false, error: e));
    }
  }

  void dispose() {
    _stateController.close();
  }
}

abstract class MovieIntent {}

class GetMovies extends MovieIntent {}

class MovieState {
  final bool isLoading;
  final (
    GeneralResult<MovieModel>,
    GeneralResult<MovieModel>,
    GeneralResult<MovieModel>,
  )?
  movies;
  final Exception? error;

  MovieState({this.isLoading = false, this.movies, this.error});

  MovieState copyWith({
    bool? isLoading,
    (
      GeneralResult<MovieModel>,
      GeneralResult<MovieModel>,
      GeneralResult<MovieModel>,
    )?
    movies,
    Exception? error,
  }) {
    return MovieState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
