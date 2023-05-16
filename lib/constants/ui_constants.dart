import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UIConstants {
  static AppBar myAppbar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        colorFilter: const ColorFilter.mode(
          Pallete.blueColor,
          BlendMode.srcIn,
        ),
        height: 35,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottonTabBarPages = [
    const Text("Feed Screen"),
    const Text("Search Screen"),
    const Text("Notification Screen"),
  ];
}
