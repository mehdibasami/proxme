import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:proxme/controller/api/mtproto_controller.dart';
import 'package:proxme/controller/api/socks5_controller.dart';
import 'package:proxme/controller/view/tab_bar_controller.dart';
import 'package:proxme/components/custom_tab_bar.dart';
import 'package:proxme/util/color.dart';

class Header extends StatelessWidget {
  final mtContoller = Get.find<MTProtoProxyController>();
  final soContoller = Get.find<Socks5ProxyController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            // height: kToolbarHeight + 32,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Image.asset(
                  'res/images/logo/logo.png',
                  width: 64,
                  height: 64,
                ),
                SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'proxme',
                      style: Get.textTheme.headline6,
                    ),
                    Text(
                      'By MehdD Basami',
                      style: Get.textTheme.headline6,
                    ),
                  ],
                ),
              ],
            ),
          ),
          GetX<TbaBarContoller>(
            init: TbaBarContoller(),
            initState: (_) {},
            builder: (_) {
              return Container(
                height: kToolbarHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [grColor1, grColor2],
                  ),
                ),
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTabBar(
                        tabs: _.tabs,
                        currentIndex: _.currentIndex.value,
                        onChanged: (index) => _.onChanged(index),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 36,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                              color: Colors.white24,
                            ),
                            child: Row(
                              children: [
                                Text('Count : '),
                                AnimatedFlipCounter(
                                  value: _.badges[_.currentIndex.value],
                                  duration: const Duration(milliseconds: 500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Material(
                              color: Colors.white30,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                              child: Tooltip(
                                message: 'Refresh',
                                child: InkWell(
                                  onTap: () {
                                    mtContoller.refreshProxy();
                                    soContoller.refreshProxy();
                                  },
                                  child: Center(
                                    child: AnimatedCrossFade(
                                      firstChild:
                                          Center(child: Icon(Ionicons.refresh)),
                                      secondChild: Center(
                                        child: SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      crossFadeState:
                                          mtContoller.isLoading.value ||
                                                  soContoller.isLoading.value
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      alignment: Alignment.center,
                                      layoutBuilder: (topChild, topChildKey,
                                          bottomChild, bottomChildKey) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: <Widget>[
                                            Positioned(
                                              key: bottomChildKey,
                                              child: bottomChild,
                                            ),
                                            Positioned(
                                              key: topChildKey,
                                              child: topChild,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
