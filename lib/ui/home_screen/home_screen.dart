import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/ui/home_screen/widgets/category_list_widget.dart';
import 'package:news_app/ui/home_screen/widgets/home_drawer/home_drawer.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/sources_widget.dart';
import 'package:news_app/ui/search_screen/search_screen.dart';
import 'package:news_app/utils/assets_manager.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel == null
            ? AppLocalizations.of(context)!.home
            : categoryModel!.title),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              child: const ImageIcon(AssetImage(AssetsManager.searchIcon))),
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
          : SourcesWidget(
              categoryModel: categoryModel!,
            ),
    );
  }

  CategoryModel? categoryModel;

  void onViewAllClicked(CategoryModel newCategoryModel) {
    setState(() {
      categoryModel = newCategoryModel;
    });
  }
}
