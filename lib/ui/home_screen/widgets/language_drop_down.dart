
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}
class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      padding: EdgeInsets.symmetric(
          vertical: height * 0.007, horizontal: width * 0.03),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.whiteColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        value: selectedLanguage,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.whiteColor,
          size: 30,
        ),
        style: TextStyles.medium20White,
        dropdownColor: AppColors.grayColor,
        menuMaxHeight: height * 0.2,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        alignment: Alignment.centerLeft,
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ar',
            child: Text('Arabic'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedLanguage = value!;
          });
        },
      ),
    );
  }
}