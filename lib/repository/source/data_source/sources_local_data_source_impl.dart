import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/repository/source/data_source/sources_local_data_source.dart';

@Injectable(as: SourcesLocalDataSource)
class SourcesLocalDataSourceImpl implements SourcesLocalDataSource {
  @override
  Future<SourcesResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('sourcesBox');
    return box.get(categoryId);
  }

  @override
  void saveSources(SourcesResponse? sourceResponse, String categoryId) async {
    var box = await Hive.openBox('sourcesBox');
    await box.put(categoryId, sourceResponse);
    await box.close();
  }
}
