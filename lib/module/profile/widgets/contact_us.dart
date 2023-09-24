import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    super.key,
    required this.size,
  });

  final Size size;
  void launchSocial(String url, String fallbackUrl) async {
    try {
      bool launched = await launchUrlString(
        mode: LaunchMode.externalApplication,
        url,
      );
      if (!launched) {
        await launchUrlString(fallbackUrl);
      }
    } catch (e) {
      await launchUrlString(
        fallbackUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            LanguageManager.translate('contactus'),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Divider(
            indent: size.width * 0.3,
            thickness: 1,
            color: AppColor.greenColor,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              height: size.height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchSocial("https://www.facebook.com/krow.wk",
                          "https://www.facebook.com/krow.wk");
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                          child: Image.asset("assets/images/facebook.png"),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        const Text(
                          'FaceBook',
                          style: TextStyle(
                            color: Color(0xff1976d2),
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: AppColor.greenColor,
                    thickness: 1,
                    indent: 4,
                    endIndent: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchSocial(
                          "https://www.messenger.com/t/100009199584322/",
                          "https://www.messenger.com/t/100009199584322/");
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                          child: Image.asset("assets/images/messenger.png"),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        const Text(
                          'Messenger',
                          style: TextStyle(
                            color: Color(0xffcc41c4),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              launchUrlString("viber://chat?number=959250361228");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                  child: Image.asset("assets/images/viber.png"),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                const Text(
                  '+959123456789',
                  style: TextStyle(
                    color: Color(0xff474079),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
