import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proxme/components/header.dart';
import 'package:proxme/controller/view/tab_bar_controller.dart';
import 'package:proxme/page/socks5_page.dart';
import 'package:proxme/util/color.dart';

import 'mtproto_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(textScaleFactor: 1),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Header(),
            SizedBox(height: 8),
            Expanded(
              child: GetX<TbaBarContoller>(
                init: TbaBarContoller(),
                builder: (_) => PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 500),
                  layoutBuilder: (entries) => Stack(
                    children: entries,
                    alignment: Alignment.center,
                  ),
                  child: [MTProtoPage(), Socks5Page()][_.currentIndex.value],
                  reverse: _.currentIndex.value == 0 ? true : false,
                  transitionBuilder:
                      (child, primaryAnimation, secondaryAnimation) =>
                          SharedAxisTransition(
                    fillColor: Colors.transparent,
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
