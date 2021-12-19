import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MTProtoItemTileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Shimmer(
        direction: const ShimmerDirection.fromLBRT(),
        child: Card(
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            leading: Container(
              height: 36,
              width: 36 + 16,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white24,
              ),
            ),
            title: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 12,
                  child: Container(
                    width: 150,
                    height: 12,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 12,
                  child: Container(
                    width: 100,
                    height: 12,
                    color: Colors.white12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
