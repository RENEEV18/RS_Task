import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_task/controller/home_controller/home_controller.dart';
import 'package:rs_task/utils/colors/colors.dart';
import 'package:rs_task/view/home/widgets/row_widget.dart';
import 'package:rs_task/view/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getData(context);
      Provider.of<HomeController>(context, listen: false).startScroll(context);
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
          body: SafeArea(
            child: value.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    controller: value.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == value.gitList.length) {
                        if (value.hasMoreItems) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }
                      final repository = value.gitList[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.book,
                          color: AppColors.kBlack,
                          size: 50,
                        ),
                        title: TextWidget(
                          name: repository.name,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          children: [
                            TextWidget(
                              name: repository.description,
                              color: AppColors.kBlack.withOpacity(0.6),
                              // fontSize: 16,
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.code,
                                    name: repository.language.toString(),
                                  ),
                                ),
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.bug_report,
                                    name: repository.openIssuesCount.toString(),
                                  ),
                                ),
                                Flexible(
                                  child: RowWidget(
                                    iconData: Icons.face_rounded,
                                    name: repository.watchersCount.toString(),
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
        );
      },
    );
  }
}
