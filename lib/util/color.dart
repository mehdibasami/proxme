import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color grColor1 = Color(0xffb92b27);
const Color grColor2 = Color(0xff1565C0);
const Color primaryColor = Color(0xff161a1d);

Color pingColor(int ping) {
  late Color color;
  if (ping <= 100) {
    color = Colors.green;
  } else if (ping > 100 && ping <= 250) {
    color = Colors.orange;
  } else if (ping > 250) {
    color = Colors.red;
  }
  return color;
}

String pingStatus(int ping) {
  late String status;
  if (ping <= 100) {
    status = 'Good';
  } else if (ping > 100 && ping <= 250) {
    status = 'Bad';
  } else if (ping > 250) {
    status = 'Very Bad';
  }
  return status;
}
