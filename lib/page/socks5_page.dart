import 'package:clipboard/clipboard.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:proxme/components/item_tile_skeleton.dart';
import 'package:proxme/components/socks5_item_tile.dart';
import 'package:proxme/controller/api/socks5_controller.dart';
import 'package:proxme/util/api_urls.dart';
import 'package:share_plus/share_plus.dart';

class Socks5Page extends StatefulWidget {
  @override
  _Socks5PageState createState() => _Socks5PageState();
}

class _Socks5PageState extends State<Socks5Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: GetX<Socks5ProxyController>(
        init: Socks5ProxyController(),
        builder: (_) {
          if (_.isLoading.value) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext context, int index) {
                return MTProtoItemTileSkeleton();
              },
            );
          }
          if (_.proxies.length <= 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.bug,
                    size: 72,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 8),
                  Text('Something Wrong', style: Get.textTheme.headline5),
                  SizedBox(height: 8),
                  Text('Try Again'),
                ],
              ),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: _.proxies.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTileCard(
                key: UniqueKey(),
                trailing: Icon(Ionicons.chevron_down),
                leading: Container(
                  alignment: Alignment.center,
                  width: 36 + 16,
                  child: Container(
                    height: 36,
                    width: 36 + 16,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white24,
                    ),
                    child: ProgressiveImage(
                      placeholder:
                          AssetImage('res/images/logo/logo_placeholder.png'),
                      image: AssetImage('res/images/flags/' +
                          _.proxies[index].country!.toLowerCase() +
                          '.png'),
                      thumbnail: AssetImage('res/images/flags/' +
                          _.proxies[index].country!.toLowerCase() +
                          '.png'),
                      height: 36,
                      width: 36 + 16,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Socks5ItemTile(proxy: _.proxies[index]),
                borderRadius: BorderRadius.circular(0),
                animateTrailing: true,
                baseColor: Colors.transparent,
                expandedColor: Colors.white10,
                elevation: 0,
                expandedTextColor: Colors.white,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 1,
                          color: Colors.white10,
                        ),
                        SizedBox(height: 8),
                        Text('IP : ' + _.proxies[index].ip!),
                        SizedBox(height: 8),
                        Text('Port : ' + _.proxies[index].port!),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              constraints: BoxConstraints(
                                  minWidth: 72, maxWidth: 72, minHeight: 36),
                              onPressed: () {
                                FlutterClipboard.copy(
                                  ApiUrl.finalSocks5Proxy(
                                    _.proxies[index].ip!,
                                    _.proxies[index].port!,
                                  ),
                                ).then(
                                  (value) {
                                    Get.rawSnackbar(
                                      icon: Icon(Ionicons.checkmark),
                                      message: 'Socks5 Proxy Copied!',
                                      duration:
                                          const Duration(milliseconds: 1500),
                                    );
                                  },
                                );
                              },
                              child: Text('Copy'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Get.theme.accentColor),
                              ),
                            ),
                            SizedBox(width: 8),
                            RawMaterialButton(
                              constraints: BoxConstraints(
                                  minWidth: 72, maxWidth: 72, minHeight: 36),
                              onPressed: () {
                                Share.share(
                                  ApiUrl.finalSocks5Proxy(
                                    _.proxies[index].ip!,
                                    _.proxies[index].port!,
                                  ),
                                  subject: 'Share Socks5 Proxy',
                                );
                              },
                              child: Text('Share'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Get.theme.accentColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
