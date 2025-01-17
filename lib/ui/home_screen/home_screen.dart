import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/category_list_widget.dart';
import 'package:news_app/ui/home_screen/widgets/home_drawer.dart';
import 'package:news_app/ui/home_screen/widgets/tab_bar_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel == null
            ? AppLocalizations.of(context)!.home
            : categoryModel!.title),
        actions: [
          const ImageIcon(AssetImage(AssetsManager.searchIcon)),
          SizedBox(width: width * 0.03),
        ],
      ),
      drawer: Drawer(
        child: HomeDrawer(
          onGoToHomeClicked: () {
            setState(() {
              categoryModel = null;
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: categoryModel == null
          ? CategoryListWidget(
              onViewAllClicked: onViewAllClicked,
            )
          : FutureBuilder<SourcesResponse?>(
              future: ApiManager.getSources(categoryModel!.id),
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
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.02),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              setState(() {
                                ApiManager.getSources(categoryModel!.id);
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

                /// we have daata here
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
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.02),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              setState(() {
                                ApiManager.getSources(categoryModel!.id);
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
                var sourcesList = snapshot.data!.sources!;
                return TabBarWidget(sourcesList: sourcesList);
              }),
    );
  }

  CategoryModel? categoryModel;

  void onViewAllClicked(CategoryModel newCategoryModel) {
    setState(() {
      categoryModel = newCategoryModel;
    });
  }
}
