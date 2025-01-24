
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/providers/language_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';
class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}
class _LanguageDropdownState extends State<LanguageDropdown> {
  String? selectedLanguage ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
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
        value: selectedLanguage ?? (languageProvider.appLanguage == 'en' ? 'en' : 'ar'),
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
        items:  [
          DropdownMenuItem(
            value: 'en',
            child: Text(AppLocalizations.of(context)!.english),
          ),
          DropdownMenuItem(
            value: 'ar',
            child: Text(AppLocalizations.of(context)!.arabic),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedLanguage = value!;
            if(value == 'en'){
              languageProvider.changeLanguage(newLanguage: value);
            }else if(value == 'ar'){
              languageProvider.changeLanguage(newLanguage: value);
            }
          });
        },
      ),
    );
  }
}