import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:proxme/abstract/api_functions.dart';
import 'package:proxme/controller/view/tab_bar_controller.dart';
import 'package:proxme/model/mt_proto_proxy_model.dart';
import 'package:dio/dio.dart';
import 'package:proxme/util/api_urls.dart';

class MTProtoProxyController extends GetxController with ApiFunctions {
  //
  final tabBarController = Get.find<TbaBarContoller>();
  RxBool isLoading = false.obs;
  RxList<MTProtoProxyModel> proxies = <MTProtoProxyModel>[].obs;
  Dio _dio = Dio(BaseOptions(connectTimeout: 10000));
  //
  @override
  void onInit() {
    super.onInit();
    fetchProxy();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> fetchProxy() async {
    try {
      tabBarController.addBadge0(0);
      isLoading(true);
      final response = await _dio.get(ApiUrl.mtprotoUri);
      if (response.statusCode == 200) {
        final result = response.data;
        proxies.value = List<MTProtoProxyModel>.from(
            result.map((json) => MTProtoProxyModel.fromJson(json)).toList());
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
      tabBarController.addBadge0(proxies.length.toDouble());
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
