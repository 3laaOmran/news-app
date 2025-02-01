import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/repository/news/data_source/news_local_data_source.dart';

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    var box = await Hive.openBox('News');
    return box.get(sourceId);
  }

  @override
  void saveNews(NewsResponse? newsResponse, String sourceId) async {
    var box = await Hive.openBox('News');
    await box.put(sourceId, newsResponse);
    await box.close();
  }
}
