import 'package:injectable/injectable.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source.dart';

@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDataSourceImpl implements SourceRemoteDataSource {
  ApiManager apiManager;

  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourcesResponse?> getSources(categoryId) {
    return apiManager.getSources(categoryId);
  }

}