import 'package:news_app/models/news_response.dart';

abstract class NewsLocalDataSource {
  Future<NewsResponse?> getNewsBySourceId(String sourceId);

  void saveNews(NewsResponse? newsResponse, String sourceId);
}
