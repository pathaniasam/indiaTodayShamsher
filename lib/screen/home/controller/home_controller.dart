import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/screen/dashboard/view/dashboard_view.dart';
import 'package:indiatodayshamsher/screen/talktoastro/view/astro_view.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  List<Widget> widgetOptions = [

  DashBoardView(),
    AstroView()

  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}