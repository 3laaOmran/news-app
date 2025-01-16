import 'package:flutter/material.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/ui/home_screen/widgets/news_widget.dart';
import 'package:news_app/utils/app_colors.dart';

class TabBarWidget extends StatefulWidget {
  final List<Source> sourcesList;
  const TabBarWidget({super.key, required this.sourcesList});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
                indicatorColor: Theme.of(context).indicatorColor,
                dividerColor: AppColors.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabs: widget.sourcesList.map((src) {
                  return SourceNameWidget(
                      text: src.name ?? '',
                      isSelected:
                          widget.sourcesList.indexOf(src) == selectedIndex);
                }).toList()),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
                child: NewsWidget(source: widget.sourcesList[selectedIndex])),
          ],
        ));
  }
}

class SourceNameWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  const SourceNameWidget({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isSelected
          ? Theme.of(context).textTheme.bodyLarge
          : Theme.of(context).textTheme.bodyMedium,
    );
  }
}
