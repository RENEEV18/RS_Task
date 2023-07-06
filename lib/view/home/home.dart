import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_task/controller/home_controller/home_controller.dart';
import 'package:rs_task/utils/colors/colors.dart';
import 'package:rs_task/view/home/widgets/row_widget.dart';
import 'package:rs_task/view/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
    Provider.of<HomeController>(context, listen: false)
        .scrollController
        .dispose();
    Provider.of<HomeController>(context, listen: false).closeHiveBox();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getData(context);
      Provider.of<HomeController>(context, listen: false).startScroll(context);
      Provider.of<HomeController>(context, listen: false).retrieveData();
      Provider.of<HomeController>(context, listen: false).checkConnectivity();
    });
    return Consumer<HomeController>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 2, 48, 92),
            title: const TextWidget(
              name: "Jake's Git",
              fontWeight: FontWeight.bold,
              color: AppColors.kWhite,
            ),
          ),
          body: value.connectivityResult == ConnectivityResult.none
              ? SafeArea(
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: value.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.book,
                          color: AppColors.kBlack,
                          size: 50,
                        ),
                        title: TextWidget(
                          name: value.localDataList[index].name,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          children: [
                            TextWidget(
                              name: value.localDataList[index].description ??
                                  value.noData,
                              color: AppColors.kBlack.withOpacity(0.6),
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.code,
                                    name: value.localDataList[index].language
                                        .toString(),
                                  ),
                                ),
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.bug_report,
                                    name: value
                                        .localDataList[index].openIssuesCount
                                        .toString(),
                                  ),
                                ),
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.face_rounded,
                                    name: value
                                        .localDataList[index].watchersCount
                                        .toString(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: value.localDataList.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                )
              : SafeArea(
                  child: value.isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return value.getData(context);
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: value.scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final itemList = value.connectivityResult ==
                                          ConnectivityResult.wifi ||
                                      value.connectivityResult ==
                                          ConnectivityResult.mobile
                                  ? value.gitList
                                  : value.localDataList;
                              if (index == value.gitList.length) {
                                if (value.hasMoreItems) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: TextWidget(
                                          name: "No Internet Connection"));
                                }
                              }
                              // final repository = value.gitList[index];

                              return ListTile(
                                leading: const Icon(
                                  Icons.book,
                                  color: AppColors.kBlack,
                                  size: 50,
                                ),
                                title: TextWidget(
                                  name: itemList[index].name,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  children: [
                                    TextWidget(
                                      name: itemList[index].description ??
                                          "No Description",
                                      color: AppColors.kBlack.withOpacity(0.6),
                                      // fontSize: 16,
                                      maxLines: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: RowWidget(
                                            iconData: Icons.code,
                                            name: itemList[index]
                                                .language
                                                .toString(),
                                          ),
                                        ),
                                        Flexible(
                                          child: RowWidget(
                                            iconData: Icons.bug_report,
                                            name: itemList[index]
                                                .openIssuesCount
                                                .toString(),
                                          ),
                                        ),
                                        Flexible(
                                          child: RowWidget(
                                            iconData: Icons.face_rounded,
                                            name: itemList[index]
                                                .watchersCount
                                                .toString(),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: value.gitList.length + 1,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ),
                ),
        );
      },
    );
  }
}
