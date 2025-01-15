import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:news_app/utils/text_styles.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: height*0.25,
          width: double.infinity,
          color: AppColors.whiteColor,
          child: Text('News App',style: TextStyles.bold24Black,),
        ),
        SizedBox(
          height: height*0.02,
        ),
        const DrawerWidget(imagePath: AssetsManager.homeIcon, text: 'Go To Home'),
        Divider(
          thickness: 1,
          color: AppColors.whiteColor,
          endIndent: width*0.05,
          indent: width*0.04,
        ),
        const DrawerWidget(imagePath: AssetsManager.themeIcon, text: 'Theme'),

        Container(
          margin: EdgeInsets.symmetric(
            horizontal: width*0.04,
            vertical: height*0.01
          ),
          padding: EdgeInsets.symmetric(
            vertical: height*0.015,
            horizontal: width*0.03
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.whiteColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark',style: TextStyles.medium20White,),
              const Icon(Icons.arrow_drop_down,color: AppColors.whiteColor,size: 30,),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColors.whiteColor,
          endIndent: width*0.05,
          indent: width*0.04,
        ),
        const DrawerWidget(imagePath: AssetsManager.languageIcon, text: 'Language'),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width*0.04,
              vertical: height*0.01
          ),
          padding: EdgeInsets.symmetric(
              vertical: height*0.015,
              horizontal: width*0.03
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.whiteColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('English',style: TextStyles.medium20White,),
              const Icon(Icons.arrow_drop_down,color: AppColors.whiteColor,size: 30,),
            ],
          ),
        ),
      ],
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  const DrawerWidget({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ImageIcon(AssetImage(imagePath),color: AppColors.whiteColor,),
          SizedBox(
            width: width*0.03
          ),
          Text(text,style: TextStyles.bold20White,),
        ],
      ),
    );
  }
}

