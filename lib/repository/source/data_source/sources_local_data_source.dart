import 'package:news_app/models/sources_response.dart';

abstract class SourcesLocalDataSource {
  Future<SourcesResponse?> getSources(String categoryId);

  void saveSources(SourcesResponse? sourceResponse, String categoryId);
}
