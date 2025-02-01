// import 'package:news_app/api/api_manager.dart';
// import 'package:news_app/repository/news/data_source/news_local_data_source.dart';
// import 'package:news_app/repository/news/data_source/news_local_data_source_impl.dart';
// import 'package:news_app/repository/news/data_source/news_remote_data_source.dart';
// import 'package:news_app/repository/news/data_source/news_remote_data_source_impl.dart';
// import 'package:news_app/repository/news/repository/news_repository.dart';
// import 'package:news_app/repository/news/repository/news_repository_impl.dart';
// import 'package:news_app/repository/source/data_source/source_remote_data_source.dart';
// import 'package:news_app/repository/source/data_source/source_remote_data_source_impl.dart';
// import 'package:news_app/repository/source/data_source/sources_local_data_source.dart';
// import 'package:news_app/repository/source/data_source/sources_local_data_source_impl.dart';
// import 'package:news_app/repository/source/repository/source_repository.dart';
// import 'package:news_app/repository/source/repository/source_repository_impl.dart';
//
// NewsRepository injectNewsRepository() {
//   return NewsRepositoryImpl(
//       remoteDataSource: injectNewsRemoteDataSource(),
//       localDataSource: injectNewsLocalDataSource(),
//   );
// }
// NewsLocalDataSource injectNewsLocalDataSource(){
//   return NewsLocalDataSourceImpl();
// }
// NewsRemoteDataSource injectNewsRemoteDataSource() {
//   return NewsRemoteDataSourceImpl(apiManager: ApiManager.getApiManagerInstance());
// }
//
//
//
// SourceRepository injectSourceRepository() {
//   return SourceRepositoryImpl(
//     sourcesLocalDataSource: injectSourceLocalDataSource(),
//       sourceRemoteDataSource: injectSourceRemoteDataSource());
// }
//
// SourcesLocalDataSource injectSourceLocalDataSource(){
//   return SourcesLocalDataSourceImpl();
// }
//
// SourceRemoteDataSource injectSourceRemoteDataSource() {
//   return SourceRemoteDataSourceImpl(apiManager: ApiManager.getApiManagerInstance());
// }
