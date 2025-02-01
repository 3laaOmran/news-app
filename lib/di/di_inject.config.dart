// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api/api_manager.dart' as _i1047;
import '../repository/news/data_source/news_local_data_source.dart' as _i438;
import '../repository/news/data_source/news_local_data_source_impl.dart'
    as _i528;
import '../repository/news/data_source/news_remote_data_source.dart' as _i344;
import '../repository/news/data_source/news_remote_data_source_impl.dart'
    as _i1045;
import '../repository/news/repository/news_repository.dart' as _i251;
import '../repository/news/repository/news_repository_impl.dart' as _i941;
import '../repository/source/data_source/source_remote_data_source.dart'
    as _i173;
import '../repository/source/data_source/source_remote_data_source_impl.dart'
    as _i559;
import '../repository/source/data_source/sources_local_data_source.dart'
    as _i92;
import '../repository/source/data_source/sources_local_data_source_impl.dart'
    as _i577;
import '../repository/source/repository/source_repository.dart' as _i1033;
import '../repository/source/repository/source_repository_impl.dart' as _i975;
import '../ui/home_screen/widgets/news/cubit/news_cubit.dart' as _i582;
import '../ui/home_screen/widgets/sources_widget/cubit/sources_cubit.dart'
    as _i527;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i173.SourceRemoteDataSource>(() =>
        _i559.SourceRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i92.SourcesLocalDataSource>(
        () => _i577.SourcesLocalDataSourceImpl());
    gh.factory<_i438.NewsLocalDataSource>(
        () => _i528.NewsLocalDataSourceImpl());
    gh.factory<_i344.NewsRemoteDataSource>(() =>
        _i1045.NewsRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i1033.SourceRepository>(() => _i975.SourceRepositoryImpl(
          sourceRemoteDataSource: gh<_i173.SourceRemoteDataSource>(),
          sourcesLocalDataSource: gh<_i92.SourcesLocalDataSource>(),
        ));
    gh.factory<_i251.NewsRepository>(() => _i941.NewsRepositoryImpl(
          remoteDataSource: gh<_i344.NewsRemoteDataSource>(),
          localDataSource: gh<_i438.NewsLocalDataSource>(),
        ));
    gh.factory<_i527.SourcesCubit>(() =>
        _i527.SourcesCubit(sourceRepository: gh<_i1033.SourceRepository>()));
    gh.factory<_i582.NewsCubit>(
        () => _i582.NewsCubit(newsRepository: gh<_i251.NewsRepository>()));
    return this;
  }
}
