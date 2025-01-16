import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/providers/language_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
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
            return Column(
              children: [
                const Text('SomeThing went wrong'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      });
                    },
                    child: const Text('tryAgain')),
              ],
            );
          }

          if (snapshot.data!.status == 'error') {
            return Column(
              children: [
                const Text('SomeThing went wrong'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      });
                    },
                    child: const Text('tryAgain')),
              ],
            );
          }
          var newsList = snapshot.data!.articles!;
          return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) => NewsItem(news: newsList[index]));
        });
  }
}

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.007, horizontal: width * 0.015),
      margin: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.035),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).indicatorColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              height: height * 0.25,
              fit: BoxFit.fill,
              width: double.infinity,
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: AppColors.grayColor,
              )),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
                size: 38,
              ),
            ),
          ),
          // child: Image.network(
          //   news.urlToImage ?? '',
          //   height: height * 0.25,
          //   fit: BoxFit.fill,
          //   width: double.infinity,
          // )),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            news.title ?? '',
            style: themeProvider.isDark()
                ? TextStyles.bold16White
                : TextStyles.bold16Black,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'By: ${news.author}',
                style: TextStyles.medium12gray,
              )),
              Text(
                timeago.format(DateTime.parse(news.publishedAt ?? ''),
                    locale: languageProvider.appLanguage),
                style: TextStyles.medium12gray,
              ),
            ],
          )
        ],
      ),
    );
  }
}
