//@GeneratedMicroModule;DataPackageModule;package:data/module/data.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data/api/ApiService.dart' as _i446;
import 'package:data/module/network_module.dart' as _i722;
import 'package:data/repository/MovieRepository.dart' as _i104;
import 'package:data/repository/TVRepository.dart' as _i983;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/repository/movie_repository.dart' as _i578;
import 'package:domain/repository/tv_repository.dart' as _i735;
import 'package:injectable/injectable.dart' as _i526;

class DataPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final networkModule = _$NetworkModule();
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i446.ApiService>(() => _i446.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i578.MovieRepository>(
        () => _i104.MovieRepositoryImpl(gh<_i446.ApiService>()));
    gh.lazySingleton<_i735.TVRepository>(
        () => _i983.TVRepositoryImpl(gh<_i446.ApiService>()));
  }
}

class _$NetworkModule extends _i722.NetworkModule {}
