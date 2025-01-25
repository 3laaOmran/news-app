import 'package:news_app/models/news_response.dart';

abstract class NewsStates {}

final class NewsPaginationLoadingState extends NewsStates {}

final class NewsLoadingState extends NewsStates {}

final class NewsErrorState extends NewsStates {
  String errorMessage;

  NewsErrorState({required this.errorMessage});
}

final class NewsSuccessState extends NewsStates {
  List<News> newsList;

  NewsSuccessState({required this.newsList});
}
