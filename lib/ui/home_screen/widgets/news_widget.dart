import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/news_details_widget.dart';
import 'package:news_app/ui/home_screen/widgets/news_item.dart';
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
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.grayColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.09,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.error_msg,
                    textAlign: TextAlign.center,
                    style: themeProvider.isDark()
                        ? TextStyles.bold24White
                        : TextStyles.bold24Black,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.isDark()
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        setState(() {
                          ApiManager.getNewsBySourceId(widget.source.id ?? '');
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.try_again,
                        style: themeProvider.isDark()
                            ? TextStyles.bold16Black
                            : TextStyles.bold16White,
                      )),
                ],
              ),
            );
          }

          if (snapshot.data!.status == 'error') {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.09,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.error_msg,
                    textAlign: TextAlign.center,
                    style: themeProvider.isDark()
                        ? TextStyles.bold24White
                        : TextStyles.bold24Black,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.isDark()
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        setState(() {
                          ApiManager.getNewsBySourceId(widget.source.id ?? '');
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.try_again,
                        style: themeProvider.isDark()
                            ? TextStyles.bold16Black
                            : TextStyles.bold16White,
                      )),
                ],
              ),
            );
          }
          var newsList = snapshot.data!.articles!;
          return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxHeight: height * 0.52,
                        ),
                        backgroundColor: AppColors.transparent,
                        context: context,
                        builder: (context) {
                          return NewsDetailsWidget(
                            imagePath: newsList[index].urlToImage ?? '',
                            newsDescription: newsList[index].description ?? '',
                            newsUrl: newsList[index].url ?? '',
                          );
                        });
                  },
                  child: NewsItem(news: newsList[index])));
        });
  }
}
