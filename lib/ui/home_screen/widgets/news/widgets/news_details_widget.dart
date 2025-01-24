import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/widgets/news/veb_view_screen.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class NewsDetailsWidget extends StatelessWidget {
  final String imagePath;
  final String newsDescription;
  final String newsUrl;

  const NewsDetailsWidget(
      {super.key,
      required this.imagePath,
      required this.newsDescription,
      required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.035, vertical: height * 0.02),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.015),
      decoration: BoxDecoration(
          color: themeProvider.isDark()
              ? AppColors.whiteColor
              : AppColors.blackColor,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              height: height * 0.25,
              fit: BoxFit.fill,
              width: double.infinity,
              imageUrl: imagePath,
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
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            newsDescription,
            maxLines: 4,
            style: themeProvider.isDark()
                ? TextStyles.medium14Black
                : TextStyles.medium14White,
          ),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.isDark()
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewScreen(newsUrl: newsUrl)));
              },
              child: Text(
                AppLocalizations.of(context)!.view_full_article,
                style: themeProvider.isDark()
                    ? TextStyles.bold16White
                    : TextStyles.bold16Black,
              )),
        ],
      ),
    );
  }
}
