//@GeneratedMicroModule;PresentationPackageModule;package:presentation/presentation.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:domain/domain.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;
import 'package:presentation/screen/detail/detail_view_model.dart' as _i356;
import 'package:presentation/screen/home/tabs/movie_view_model.dart' as _i863;
import 'package:presentation/screen/home/tabs/tv_view_model.dart' as _i404;

class PresentationPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i356.DetailViewModel>(() => _i356.DetailViewModel());
    gh.factory<_i863.MovieViewModel>(
        () => _i863.MovieViewModel(gh<_i494.MovieRepository>()));
    gh.factory<_i404.TvViewModel>(
        () => _i404.TvViewModel(gh<_i494.TVRepository>()));
  }
}
