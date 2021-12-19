import 'package:get/get.dart';

class TbaBarContoller extends GetxController {
  //
  RxList<String> tabs = <String>['MTProto', 'Socks5'].obs;
  RxInt currentIndex = 0.obs;
  RxList<double> badges = <double>[0, 0].obs;
  //

  onChanged(int index) {
    currentIndex(index);
  }

  addBadge0(double badge) {
    badges[0] = badge;
    update();
  }

  addBadge1(double badge) {
    badges[1] = badge;
    update();
  }
}
