import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source.dart';
import 'package:news_app/repository/source/repository/source_repository.dart';

import '../data_source/sources_local_data_source.dart';

@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;
  SourcesLocalDataSource sourcesLocalDataSource;

  SourceRepositoryImpl(
      {required this.sourceRemoteDataSource,
      required this.sourcesLocalDataSource});

  @override
  Future<SourcesResponse?> getSources(String categoryId) async {
    final List<ConnectivityResult> connectionResult =
        await Connectivity().checkConnectivity();
    if (connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi)) {
      var sourceResponse = await sourceRemoteDataSource.getSources(categoryId);
      sourcesLocalDataSource.saveSources(sourceResponse, categoryId);
      return sourceResponse;
    } else {
      return sourcesLocalDataSource.getSources(categoryId);
    }
  }
}
