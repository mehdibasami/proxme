import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proxme/controller/api/mtproto_controller.dart';
import 'package:proxme/controller/api/socks5_controller.dart';
import 'package:proxme/controller/view/tab_bar_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';
import 'page/home_page.dart';
import 'util/color.dart';

void main() {
  setPathUrlStrategy();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'proxme - Free Telegram Proxy',
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 100,
                  color: Colors.black87,
                ),
              ],
            ),
            child: child,
          ),
          maxWidth: 900,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          alignment: Alignment.center,
          backgroundColor: primaryColor,
          background: Container(
            color: primaryColor,
          ),
        );
      },
      initialBinding: BindingsBuilder(
        () => [
          Get.put(TbaBarContoller()),
          Get.put(MTProtoProxyController()),
          Get.put(Socks5ProxyController()),
        ],
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: grColor2,
        primaryColor: primaryColor,
        fontFamily: 'Cream',
      ),
      home: HomePage(),
    );
  }
}
