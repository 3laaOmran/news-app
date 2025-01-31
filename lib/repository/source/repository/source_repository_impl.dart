import 'package:news_app/models/sources_response.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source.dart';
import 'package:news_app/repository/source/repository/source_repository.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;

  SourceRepositoryImpl({required this.sourceRemoteDataSource});

  @override
  Future<SourcesResponse?> getSources(String categoryId) {
    return sourceRemoteDataSource.getSources(categoryId);
  }
}
