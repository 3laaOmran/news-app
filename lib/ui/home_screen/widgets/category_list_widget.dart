import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatelessWidget {
  List<CategoryModel> categoriesList = [];
  Function onViewAllClicked;

  CategoryListWidget({super.key, required this.onViewAllClicked});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    categoriesList = CategoryModel.getCategoryList(themeProvider.isDark());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.006),
          child: Text(
            '${AppLocalizations.of(context)!.welcome} \n ${AppLocalizations.of(context)!.welcome_msg}',
            style: themeProvider.isDark()
                ? TextStyles.medium24White
                : TextStyles.medium24black,
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.006),
              child: Stack(
                alignment: index % 2 == 0
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(categoriesList[index].imagePath)),
                  GestureDetector(
                    onTap: () {
                      onViewAllClicked(categoriesList[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.02),
                      decoration: BoxDecoration(
                          color: AppColors.grayColor,
                          borderRadius: BorderRadius.circular(2000)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.view_all,
                              style: themeProvider.isDark()
                                  ? TextStyles.medium24White
                                  : TextStyles.medium24black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.015),
                              decoration: BoxDecoration(
                                  color: themeProvider.isDark()
                                      ? AppColors.blackColor
                                      : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(2000)),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: themeProvider.isDark()
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: categoriesList.length,
        )),
      ],
    );
  }
}
