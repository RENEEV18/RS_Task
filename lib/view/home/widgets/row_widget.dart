import 'package:flutter/material.dart';
import 'package:rs_task/utils/colors/colors.dart';
import 'package:rs_task/utils/style/style.dart';
import 'package:rs_task/view/widgets/text_widget.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.iconData, required this.name});
  final IconData iconData;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: AppColors.kBlack,
        ),
        AppSize.kWidth10,
        Flexible(
          child: TextWidget(
            name: name,
            color: AppColors.kBlack.withOpacity(0.6),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
