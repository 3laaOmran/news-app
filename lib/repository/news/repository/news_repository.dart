import 'package:news_app/models/news_response.dart';

//TODO: Interface
abstract class NewsRepository {
  Future<NewsResponse?> getNewsBySourceId(String sourceId);
}