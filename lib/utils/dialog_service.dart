import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../config/language/language_manager.dart';
import 'color_constant.dart';

class DialogActions {
  static Future<void> okDialog(
    BuildContext context,
    String title,
    String subTitle,
    String body, {
    required List<Widget> action,
  }) async {
    var size = MediaQuery.of(context).size;
    final alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.2, vertical: size.height * 0.35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily:
                    LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
                fontWeight: FontWeight.bold,
                color: AppColor.swatch,
                fontSize: 13,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontFamily:
                    LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            body,
            style: TextStyle(
              fontFamily:
                  LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
              fontSize: 14,
              color: AppColor.swatch,
            ),
          ),
        ],
      ),
      actions: action,
    );

    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showLoaderDialog(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.swatch,
      insetPadding: EdgeInsets.symmetric(
          horizontal: size.width / 2.5, vertical: size.height / 2.3),
      content: Builder(builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SpinKitChasingDots(),
            ),
          ],
        );
      }),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> comfirmDialog(
    BuildContext context,
    String title,
    String subTitle,
    String body,
    VoidCallback onPress,
  ) async {
    final alert = AlertDialog(
      //backgroundColor: AppColor.secondColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily:
                    LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
                fontWeight: FontWeight.bold,
                color: AppColor.swatch,
                fontSize: 13,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontFamily:
                    LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
                fontWeight: FontWeight.bold,
                color: AppColor.swatch,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            body,
            style: TextStyle(
              fontFamily:
                  LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
              fontSize: 14,
              color: AppColor.swatch,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              fontFamily:
                  LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            "Print",
            style: TextStyle(
              fontFamily:
                  LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
              color: AppColor.swatch,
            ),
          ),
        ),
      ],
    );
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget appLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
