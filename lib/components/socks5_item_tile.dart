import 'package:flutter/material.dart';
import 'package:proxme/model/socks_5_proxy_model.dart';
import 'package:proxme/util/api_urls.dart';
import 'package:proxme/util/color.dart';
import 'package:proxme/util/countries_list.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class Socks5ItemTile extends StatelessWidget {
  final Socks5ProxyModel proxy;
  const Socks5ItemTile({Key? key, required this.proxy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListTile(
        title: Text(
          countriesList.firstWhere((e) => e['code'] == proxy.country)['name'],
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Row(
          children: [
            Text('Status : '),
            Text(
              pingStatus(int.tryParse(proxy.ping!)!),
              style: TextStyle(
                color: pingColor(int.tryParse(proxy.ping!)!),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pingColor(int.tryParse(proxy.ping!)!),
              ),
            )
          ],
        ),
        trailing: RawMaterialButton(
          onPressed: () async {
            Future.delayed(
              Duration(milliseconds: 100),
              () {
                ul.launch(ApiUrl.finalSocks5Proxy(proxy.ip!, proxy.port!));
              },
            );
          },
          child: Text('Connect'),
          hoverColor: pingColor(int.tryParse(proxy.ping!)!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 2,
              color: pingColor(int.tryParse(proxy.ping!)!),
            ),
          ),
        ),
      ),
    );
  }
}
