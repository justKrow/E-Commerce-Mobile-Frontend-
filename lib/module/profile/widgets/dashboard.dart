import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:###/module/profile/widgets/account_delete_warning.dart';
import 'package:###/module/profile/widgets/profile_list_tile.dart';
import 'package:###/module/profile/widgets/suggestion_form.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';

var titleSuggestionText = TextEditingController();

class DashBoard extends StatelessWidget {
  const DashBoard({
    super.key,
    required this.size,
    required this.titleSuggestionText,
    required this.bodySuggestionText,
  });

  final Size size;
  final TextEditingController titleSuggestionText;
  final TextEditingController bodySuggestionText;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 2,
      mainAxisSpacing: size.height * 0.01,
      crossAxisSpacing: size.width * 0.01,
      children: [
        DashboardTile(
          text: LanguageManager.translate('orderhistory'),
          size: size,
          onPressed: () {},
          icon: IconlyLight.time_circle,
        ),
        DashboardTile(
          text: LanguageManager.translate('suggestform'),
          size: size,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SuggestionForm(
                      size: size,
                      titleSuggestionText: titleSuggestionText,
                      bodySuggestionText: bodySuggestionText);
                });
          },
          icon: IconlyLight.edit,
        ),
        DashboardTile(
          size: size,
          text: LanguageManager.translate('policy'),
          onPressed: () {},
          icon: IconlyLight.paper,
        ),
        InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AccountDeleteWarning(size: size);
                });
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.redColor,
              ),
              width: size.width * 0.2,
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      LanguageManager.translate('deleteAccount'),
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColor.mildGreen,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  const Icon(
                    IconlyLight.delete,
                    size: 20,
                    color: AppColor.mildGreen,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
