import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int index) onChanged;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var tab in this.tabs)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 200),
              tween: Tween(end: this.tabs.indexOf(tab) == this.currentIndex ? 1 : 0),
              curve: Curves.linear,
              builder: (BuildContext context, double value, Widget? child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.lerp(
                      Colors.transparent,
                      Colors.white30,
                      value,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0,
                            child: InkWell(
                              onTap: () => this.onChanged.call(this.tabs.indexOf(tab)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                alignment: Alignment.center,
                                child: Text(
                                  tab,
                                  style: TextStyle.lerp(
                                    Get.textTheme.subtitle1!.copyWith(color: Colors.white60),
                                    Get.textTheme.subtitle1,
                                    value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
