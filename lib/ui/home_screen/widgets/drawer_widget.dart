import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';

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
          ImageIcon(
            AssetImage(imagePath),
            color: AppColors.whiteColor,
          ),
          SizedBox(width: width * 0.03),
          Text(
            text,
            style: TextStyles.bold20White,
          ),
        ],
      ),
    );
  }
}
