import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:proxme/abstract/api_functions.dart';
import 'package:dio/dio.dart';
import 'package:proxme/controller/view/tab_bar_controller.dart';
import 'package:proxme/model/socks_5_proxy_model.dart';
import 'package:proxme/util/api_urls.dart';

class Socks5ProxyController extends GetxController with ApiFunctions {
  //
  final tabBarController = Get.find<TbaBarContoller>();
  RxBool isLoading = false.obs;
  RxList<Socks5ProxyModel> proxies = <Socks5ProxyModel>[].obs;
  Dio _dio = Dio(BaseOptions(connectTimeout: 10000));
  //
  @override
  void onInit() {
    super.onInit();
    tabBarController.addBadge1(0);
    fetchProxy();
  }

  @override
  Future<void> fetchProxy() async {
    try {
      isLoading(true);
      tabBarController.addBadge1(0);
      final response = await _dio.get(ApiUrl.socks5Uri);
      if (response.statusCode == 200) {
        final result = response.data;
        proxies.value = List<Socks5ProxyModel>.from(
            result.map((json) => Socks5ProxyModel.fromJson(json)).toList());
        proxies.sort((a, b) {
          return int.tryParse(a.ping!)!.compareTo(int.tryParse(b.ping!)!);
        });
      }
    } on SocketException {
      print('SocketException');
    } on TimeoutException {
      print('TimeoutException');
    } finally {
      isLoading(false);
      tabBarController.addBadge1(proxies.length.toDouble());
    }
    return super.fetchProxy();
  }

  @override
  void refreshProxy() {
    super.refreshProxy();
    proxies.clear();
    fetchProxy();
  }
}
