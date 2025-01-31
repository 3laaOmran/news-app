import 'package:news_app/models/sources_response.dart';

abstract class SourceRepository {
  Future<SourcesResponse?> getSources(String categoryId);
}
