import 'package:flutter/material.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../utils/color_constant.dart';

class AccountDeleteWarning extends StatelessWidget {
  const AccountDeleteWarning({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.redColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Icon(
                Icons.warning_amber_outlined,
                color: Colors.amber,
                size: 30,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              LanguageManager.translate('areYouSureYouWantToDeleteYourAccount'),
              style: const TextStyle(
                  color: AppColor.scaffoldBackgroundColor, fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              LanguageManager.translate("deleteAccountWarning"),
              style: const TextStyle(color: Colors.yellowAccent),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.yellowAccent)),
                  child: TextButton(
                      onPressed: () {
                        context.left(Routes.auth, (route) => false);
                      },
                      child: FittedBox(
                        child: Text(
                          LanguageManager.translate("deleteAccount"),
                          style: const TextStyle(color: Colors.yellowAccent),
                        ),
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColor.greenColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: TextButton(
                      onPressed: () {
                        context.back();
                      },
                      child: Text(
                        LanguageManager.translate("dontDelete"),
                        style: const TextStyle(
                            color: AppColor.scaffoldBackgroundColor),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
