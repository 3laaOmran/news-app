import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ThemeDropdown extends StatefulWidget {
  const ThemeDropdown({super.key});

  @override
  State<ThemeDropdown> createState() => _ThemeDropdownState();
}
class _ThemeDropdownState extends State<ThemeDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);

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
        value: selectedValue ?? (themeProvider.isDark() ? 'dark' : 'light'),
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
            value: 'dark',
            child: Text(AppLocalizations.of(context)!.dark),
          ),
          DropdownMenuItem(
            value: 'light',
            child: Text(AppLocalizations.of(context)!.light),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
            if(value== 'light'){
              themeProvider.changeAppTheme(ThemeMode.light);
            }else if(value == 'dark'){
              themeProvider.changeAppTheme(ThemeMode.dark);
            }});
        },
      ),
    );
  }
}