import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/ui/home_screen/widgets/news/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsLoadingState());

  List<News> newsList = []; // Store all loaded news items
  bool hasReachedMax = false; // Track if all pages have been loaded

  void getNewsBySourceId(String sourceId, int page) async {
    if (hasReachedMax) return; // Stop fetching if all pages are loaded

    if (page == 1) {
      // Reset the list when fetching the first page
      newsList.clear();
      emit(NewsLoadingState());
    } else {
      // Emit a loading state for pagination
      emit(NewsPaginationLoadingState());
    }

    try {
      // Fetch news from the API
      var response = await ApiManager.getNewsBySourceId(sourceId, page);

      if (response!.articles!.isEmpty) {
        // No more news to load
        hasReachedMax = true;
        emit(NewsSuccessState(newsList: newsList));
      } else {
        // Append new news items to the existing list
        newsList.addAll(response.articles!);
        emit(NewsSuccessState(newsList: newsList));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}