import 'package:news_app/models/sources_response.dart';

abstract class SourceRemoteDataSource {
  Future<SourcesResponse?> getSources(categoryId);
}