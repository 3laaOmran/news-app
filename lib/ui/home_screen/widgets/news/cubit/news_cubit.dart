import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/repository/news/repository/news_repository.dart';

import 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsStates> {
  NewsRepository newsRepository;

  NewsCubit({required this.newsRepository}) : super(NewsLoadingState());

  void getNewsBySourceId(String sourceId) async {
    try {
      emit(NewsLoadingState());
      var response = await newsRepository.getNewsBySourceId(sourceId);
      if (response!.status == 'error') {
        emit(NewsErrorState(errorMessage: response.message!));
        return;
      }
      if (response.status == 'ok') {
        emit(NewsSuccessState(newsList: response.articles!));
        return;
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
