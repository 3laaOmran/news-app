import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/ui/home_screen/widgets/news/news_widget.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/cubit/sources_cubit.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/cubit/sources_state.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../../di/di_inject.dart';
import '../../../repository/source/repository/source_repository.dart';

class TabBarWidget extends StatefulWidget {
  final List<Source> sourcesList;
  const TabBarWidget({super.key, required this.sourcesList});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  var cubit = SourcesCubit(sourceRepository: getIt<SourceRepository>());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<SourcesCubit, SourcesStates>(
      bloc: cubit,
      builder: (context, state) {
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
                      cubit.changeSelectedIndex(index);
                    },
                    tabs: widget.sourcesList.map((src) {
                      return SourceNameWidget(
                          text: src.name ?? '',
                          isSelected: widget.sourcesList.indexOf(src) ==
                              cubit.selectedIndex);
                    }).toList()),
                SizedBox(
                  height: height * 0.02,
                ),
                Expanded(child: BlocBuilder<SourcesCubit, SourcesStates>(
                  builder: (context, state) {
                    return NewsWidget(
                        key: ValueKey(cubit.selectedIndex),
                        source: widget.sourcesList[cubit.selectedIndex]);
                  },
                )),
              ],
            ));
      },
    );
  }
}

class SourceNameWidget extends StatelessWidget {
  final String text;
  final bool isSelected;

  const SourceNameWidget(
      {super.key, required this.text, required this.isSelected});

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
