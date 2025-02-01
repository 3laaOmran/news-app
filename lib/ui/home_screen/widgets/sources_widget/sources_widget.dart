import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/di/di_inject.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/repository/source/repository/source_repository.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/cubit/sources_cubit.dart';
import 'package:news_app/ui/home_screen/widgets/sources_widget/cubit/sources_state.dart';
import 'package:news_app/ui/home_screen/widgets/tab_bar_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class SourcesWidget extends StatefulWidget {
  final CategoryModel categoryModel;

  const SourcesWidget({super.key, required this.categoryModel});

  @override
  State<SourcesWidget> createState() => _SourcesWidgetState();
}

class _SourcesWidgetState extends State<SourcesWidget> {
  SourcesCubit cubit =
      SourcesCubit(sourceRepository: getIt<SourceRepository>());

  @override
  void initState() {
    cubit.getSources(widget.categoryModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (context) => cubit,
      child:
          BlocBuilder<SourcesCubit, SourcesStates>(builder: (context, state) {
        if (state is SourcesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.grayColor,
            ),
          );
        } else if (state is SourcesErrorState) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.09,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                  style: themeProvider.isDark()
                      ? TextStyles.bold24White
                      : TextStyles.bold24Black,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.isDark()
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      cubit.getSources(widget.categoryModel.id);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.try_again,
                      style: themeProvider.isDark()
                          ? TextStyles.bold16Black
                          : TextStyles.bold16White,
                    )),
              ],
            ),
          );
        } else if (state is SourcesSuccessState) {
          return TabBarWidget(sourcesList: state.sourcesList);
        }
        return Container(); // unreachable
      }),
    );
    // FutureBuilder<SourcesResponse?>(
    //   future: ApiManager.getSources(widget.categoryModel.id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(
    //           color: AppColors.grayColor,
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Padding(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: width * 0.09,
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               AppLocalizations.of(context)!.error_msg,
    //               textAlign: TextAlign.center,
    //               style: themeProvider.isDark()
    //                   ? TextStyles.bold24White
    //                   : TextStyles.bold24Black,
    //             ),
    //             SizedBox(
    //               height: height * 0.02,
    //             ),
    //             ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                     backgroundColor: themeProvider.isDark()
    //                         ? AppColors.whiteColor
    //                         : AppColors.blackColor,
    //                     padding: EdgeInsets.symmetric(
    //                         vertical: height * 0.02),
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16))),
    //                 onPressed: () {
    //                   setState(() {
    //                     ApiManager.getSources(widget.categoryModel!.id);
    //                   });
    //                 },
    //                 child: Text(
    //                   AppLocalizations.of(context)!.try_again,
    //                   style: themeProvider.isDark()
    //                       ? TextStyles.bold16Black
    //                       : TextStyles.bold16White,
    //                 )),
    //           ],
    //         ),
    //       );
    //     }
    //
    //     /// we have daata here
    //     if (snapshot.data!.status == 'error') {
    //       return Padding(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: width * 0.09,
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               AppLocalizations.of(context)!.error_msg,
    //               textAlign: TextAlign.center,
    //               style: themeProvider.isDark()
    //                   ? TextStyles.bold24White
    //                   : TextStyles.bold24Black,
    //             ),
    //             SizedBox(
    //               height: height * 0.02,
    //             ),
    //             ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                     backgroundColor: themeProvider.isDark()
    //                         ? AppColors.whiteColor
    //                         : AppColors.blackColor,
    //                     padding: EdgeInsets.symmetric(
    //                         vertical: height * 0.02),
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16))),
    //                 onPressed: () {
    //                   setState(() {
    //                     ApiManager.getSources(widget.categoryModel!.id);
    //                   });
    //                 },
    //                 child: Text(
    //                   AppLocalizations.of(context)!.try_again,
    //                   style: themeProvider.isDark()
    //                       ? TextStyles.bold16Black
    //                       : TextStyles.bold16White,
    //                 )),
    //           ],
    //         ),
    //       );
    //     }
    //     var sourcesList = snapshot.data!.sources!;
    //     return TabBarWidget(sourcesList: sourcesList);
    //   });
  }
}
