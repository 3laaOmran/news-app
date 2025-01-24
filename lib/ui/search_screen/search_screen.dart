import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/news/widgets/news_details_widget.dart';
import 'package:news_app/ui/home_screen/widgets/news/widgets/news_item.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search_screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchText = '';
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.07),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchText = value;
                setState(() {});
              },
              cursorColor: AppColors.grayColor,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      width: 1,
                      color: themeProvider.isDark()
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      width: 1,
                      color: themeProvider.isDark()
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    )),
                prefixIcon: ImageIcon(
                  const AssetImage(AssetsManager.searchIcon),
                  color: themeProvider.isDark()
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        searchController.text = '';
                        searchText = '';
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: themeProvider.isDark()
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    )),
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: themeProvider.isDark()
                    ? TextStyles.medium20White
                    : TextStyles.medium20Black,
              ),
            ),
          ),
          FutureBuilder<NewsResponse?>(
              future: ApiManager.getSearch(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.02),
                        child: const Center(
                          child: LinearProgressIndicator(
                            color: AppColors.grayColor,
                          ),
                        ),
                      ),
                    ],
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
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.02),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              setState(() {
                                ApiManager.getSearch(searchText);
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
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.15,
                          ),
                          Image.asset(AssetsManager.searchImage),
                          searchController.text.isNotEmpty
                              ? Text(
                                  '${AppLocalizations.of(context)!.no_search_data} ${searchController.text}',
                                  style: themeProvider.isDark()
                                      ? TextStyles.medium20White
                                      : TextStyles.medium20Black,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }
                var newsList = snapshot.data!.articles;
                return newsList!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        constraints: BoxConstraints(
                                          maxHeight: height * 0.52,
                                        ),
                                        backgroundColor: AppColors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return NewsDetailsWidget(
                                            imagePath:
                                                newsList[index].urlToImage ??
                                                    '',
                                            newsDescription:
                                                newsList[index].description ??
                                                    '',
                                            newsUrl: newsList[index].url ?? '',
                                          );
                                        });
                                  },
                                  child: NewsItem(news: newsList[index]));
                            }),
                      )
                    : searchController.text.isNotEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AssetsManager.searchImage),
                                Text(
                                  '${AppLocalizations.of(context)!.no_search_data} ${searchController.text}',
                                  style: themeProvider.isDark()
                                      ? TextStyles.medium20White
                                      : TextStyles.medium20Black,
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AssetsManager.searchImage),
                              ],
                            ),
                          );
              })
        ],
      ),
    );
  }
}
