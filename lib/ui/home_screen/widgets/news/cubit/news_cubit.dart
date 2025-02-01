import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/repository/news/repository/news_repository.dart';
import 'package:news_app/ui/home_screen/widgets/news/cubit/news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsStates> {
  final NewsRepository newsRepository;

  NewsCubit({required this.newsRepository}) : super(NewsLoadingState());

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
      var response = await newsRepository.getNewsBySourceId(sourceId);
      
      if (response == null || response.status == 'error') {
        emit(NewsErrorState(errorMessage: response?.message ?? "Unknown error"));
        return;
      }

      if (response.articles!.isEmpty) {
        hasReachedMax = true;
      } else {
        newsList.addAll(response.articles!);
      }

      emit(NewsSuccessState(newsList: newsList));
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
