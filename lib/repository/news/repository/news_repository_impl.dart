import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/repository/news/data_source/news_local_data_source.dart';
import 'package:news_app/repository/news/data_source/news_remote_data_source.dart';
import 'package:news_app/repository/news/repository/news_repository.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource remoteDataSource;
  NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource}); // Constructor Injection
  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    final List<ConnectivityResult> connectionResult =
        await Connectivity().checkConnectivity();
    if (connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi)) {
      var newsResponse = await remoteDataSource.getNewsBySourceId(sourceId);
      localDataSource.saveNews(newsResponse, sourceId);
      return newsResponse;
    } else {
      return localDataSource.getNewsBySourceId(sourceId);
    }
  }

}