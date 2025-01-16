import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/drawer_widget.dart';
import 'package:news_app/ui/home_screen/widgets/theme_drop_down.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

import 'language_drop_down.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: height * 0.25,
          width: double.infinity,
          color:themeProvider.isDark()?AppColors.grayColor: AppColors.whiteColor,
          child: Text(
            'News App',
            style:themeProvider.isDark()?TextStyles.bold24White: TextStyles.bold24Black,
          ),
        ),
        Divider(
          thickness: 1,
          height: 0,
          color: AppColors.grayColor,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        const DrawerWidget(
            imagePath: AssetsManager.homeIcon, text: 'Go To Home'),
        Divider(
          thickness: 1,
          color: AppColors.whiteColor,
          endIndent: width * 0.05,
          indent: width * 0.04,
        ),
        const DrawerWidget(imagePath: AssetsManager.themeIcon, text: 'Theme'),
        const ThemeDropdown(),
        Divider(
          thickness: 1,
          color: AppColors.whiteColor,
          endIndent: width * 0.05,
          indent: width * 0.04,
        ),
        const DrawerWidget(
            imagePath: AssetsManager.languageIcon, text: 'Language'),
        const LanguageDropdown(),
      ],
    );
  }
}