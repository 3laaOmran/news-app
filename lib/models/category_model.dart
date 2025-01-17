import 'package:news_app/utils/assets_manager.dart';

class CategoryModel {
  String id;
  String title;
  String imagePath;

  CategoryModel(
      {required this.id, required this.title, required this.imagePath});

  //
  static List<CategoryModel> getCategoryList(bool isDark) {
    return [
      CategoryModel(
        id: 'general',
        title: 'General',
        imagePath: isDark
            ? AssetsManager.generalDarkMode
            : AssetsManager.generalLightMode,
      ),
      CategoryModel(
        id: 'business',
        title: 'Business',
        imagePath: isDark
            ? AssetsManager.businessDarkMode
            : AssetsManager.businessLightMode,
      ),
      CategoryModel(
        id: 'sports',
        title: 'Sports',
        imagePath: isDark
            ? AssetsManager.sportsDarkMode
            : AssetsManager.sportsLightMode,
      ),
      CategoryModel(
        id: 'technology',
        title: 'Technology',
        imagePath: isDark
            ? AssetsManager.technologyDarkMode
            : AssetsManager.technologyLightMode,
      ),
      CategoryModel(
        id: 'science',
        title: 'Science',
        imagePath: isDark
            ? AssetsManager.scienceDarkMode
            : AssetsManager.scienceLightMode,
      ),
      CategoryModel(
        id: 'health',
        title: 'Health',
        imagePath: isDark
            ? AssetsManager.healthDarkMode
            : AssetsManager.healthLightMode,
      ),
      CategoryModel(
        id: 'entertainment',
        title: 'Entertainment',
        imagePath: isDark
            ? AssetsManager.entertainmentDarkMode
            : AssetsManager.entertainmentLightMode,
      ),
    ];
  }
}
