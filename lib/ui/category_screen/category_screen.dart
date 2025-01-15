import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/sources_responce.dart';
import 'package:news_app/ui/category_screen/widgets/home_drawer.dart';
import 'package:news_app/ui/category_screen/widgets/tab_bar_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/assets_manager.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category_screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('General'),
        actions: [
          const ImageIcon(AssetImage(AssetsManager.searchIcon)),
          SizedBox(width: width * 0.03),
        ],
      ),
      drawer: const Drawer(
        child: HomeDrawer(),
      ),
      body: FutureBuilder<SourcesResponse?>(
          future: ApiManager.getSources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.grayColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Text('SomeThing went wrong'),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ApiManager.getSources();
                        });
                      },
                      child: const Text('tryAgain')),
                ],
              );
            }

            /// we have daata here
            if (snapshot.data!.status == 'error') {
              return Column(
                children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ApiManager.getSources();
                        });
                      },
                      child: const Text('tryAgain')),
                ],
              );
            }
            var sourcesList = snapshot.data!.sources!;
            return TabBarWidget(sourcesList: sourcesList);
          }),
    );
  }
}
