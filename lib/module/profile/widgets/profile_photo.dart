import 'dart:io';

import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.size,
    required this.profilePhotoPath,
  });

  final Size size;
  final String? profilePhotoPath;

  @override
  Widget build(BuildContext context) {
    return (profilePhotoPath != null)
        ? CircleAvatar(
            radius: size.height * 0.075,
            backgroundColor: AppColor.mildGreen,
            child: CircleAvatar(
              radius: size.height * 0.068,
              backgroundColor: const Color.fromARGB(120, 20, 232, 50),
              backgroundImage: FileImage(
                File(profilePhotoPath!),
              ),
              child: const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColor.mildGreen,
                  child: Icon(
                    Icons.camera_alt_sharp,
                    size: 22,
                    color: AppColor.swatch,
                  ),
                ),
              ),
            ),
          )
        : CircleAvatar(
            radius: size.height * 0.07,
            backgroundColor: AppColor.mildGreen,
            child: CircleAvatar(
              radius: size.height * 0.068,
              backgroundColor: const Color.fromARGB(120, 20, 232, 50),
              backgroundImage:
                  const AssetImage('assets/images/profile_icon.png'),
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                  color: AppColor.swatch,
                ),
              ),
            ));
  }
}
