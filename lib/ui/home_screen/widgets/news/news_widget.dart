import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/news/cubit/news_cubit.dart';
import 'package:news_app/ui/home_screen/widgets/news/cubit/news_state.dart';
import 'package:news_app/ui/home_screen/widgets/news/widgets/news_details_widget.dart';
import 'package:news_app/ui/home_screen/widgets/news/widgets/news_item.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';
class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final NewsCubit cubit = NewsCubit();
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    cubit.getNewsBySourceId(widget.source.id ?? '', currentPage);
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      currentPage++;
      cubit.getNewsBySourceId(widget.source.id ?? '', currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<NewsCubit, NewsStates>(
      bloc: cubit,
      builder: (context, state) {
        if (state is NewsErrorState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                  style: themeProvider.isDark()
                      ? TextStyles.bold24White
                      : TextStyles.bold24Black,
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.isDark()
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    cubit.getNewsBySourceId(
                        widget.source.id ?? '', currentPage);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: themeProvider.isDark()
                        ? TextStyles.bold16Black
                        : TextStyles.bold16White,
                  ),
                ),
              ],
            ),
          );
        } else if (state is NewsSuccessState) {
          return ListView.builder(
            controller: scrollController,
            itemCount: state.newsList.length + 1,
            itemBuilder: (context, index) {
              if (index < state.newsList.length) {
                // Display news items
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: height * 0.52),
                      backgroundColor: AppColors.transparent,
                      context: context,
                      builder: (context) {
                        return NewsDetailsWidget(
                          imagePath: state.newsList[index].urlToImage ?? '',
                          newsDescription:
                              state.newsList[index].description ?? '',
                          newsUrl: state.newsList[index].url ?? '',
                        );
                      },
                    );
                  },
                  child: NewsItem(news: state.newsList[index]),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.grayColor,
                    ),
                  ),
                );
              }
            },
          );
        } else if (state is NewsPaginationLoadingState) {
          return ListView.builder(
            controller: scrollController,
            itemCount: cubit.newsList.length + 1,
            itemBuilder: (context, index) {
              if (index < cubit.newsList.length) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: height * 0.52),
                      backgroundColor: AppColors.transparent,
                      context: context,
                      builder: (context) {
                        return NewsDetailsWidget(
                          imagePath: cubit.newsList[index].urlToImage ?? '',
                          newsDescription:
                              cubit.newsList[index].description ?? '',
                          newsUrl: cubit.newsList[index].url ?? '',
                        );
                      },
                    );
                  },
                  child: NewsItem(news: cubit.newsList[index]),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.grayColor,
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.grayColor,
            ),
          );
        }
      },
    );
  }
}