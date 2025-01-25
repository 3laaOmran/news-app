import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/ui/home_screen/widgets/news/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsLoadingState());

  List<News> newsList = [];
  bool hasReachedMax = false;
  void getNewsBySourceId(String sourceId, int page) async {
    if (hasReachedMax) return;

    if (page == 1) {
      newsList.clear();
      emit(NewsLoadingState());
    } else {
      emit(NewsPaginationLoadingState());
    }

    try {
      var response = await ApiManager.getNewsBySourceId(sourceId, page);
      if (response!.articles!.isEmpty) {
        hasReachedMax = true;
        emit(NewsSuccessState(newsList: newsList));
      } else {
        newsList.addAll(response.articles!);
        emit(NewsSuccessState(newsList: newsList));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}