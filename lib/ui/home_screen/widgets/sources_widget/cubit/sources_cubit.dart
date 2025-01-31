import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source.dart';
import 'package:news_app/repository/source/data_source/source_remote_data_source_impl.dart';
import 'package:news_app/repository/source/repository/source_repository.dart';
import 'package:news_app/repository/source/repository/source_repository_impl.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/cubit/sources_state.dart';

class SourcesCubit extends Cubit<SourcesStates> {
  SourceRepository sourceRepository;

  SourcesCubit({required this.sourceRepository}) : super(SourcesLoadingState());

  void getSources(String categoryId) async {
    try {
      emit(SourcesLoadingState());
      var response = await sourceRepository.getSources(categoryId);
      if (response!.status == 'error') {
        emit(SourcesErrorState(errorMessage: response.message!));
        return;
      }
      if (response.status == 'ok') {
        emit(SourcesSuccessState(sourcesList: response.sources!));
        return;
      }
    } catch (e) {
      emit(SourcesErrorState(errorMessage: e.toString()));
    }
  }

  int selectedIndex = 0;

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState(selectedIndex));
  }
}
