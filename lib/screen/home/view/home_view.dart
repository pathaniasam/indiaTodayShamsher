
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/screen/home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder<HomeController>(
          init: Get.find<HomeController>(),
          builder: (controller) =>

              controller.widgetOptions.elementAt(controller.selectedIndex))
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
          init: Get.find<HomeController>(),
          builder: (controller)
          => BottomNavigationBar(
        backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.grey,size: 20,),
              activeIcon:Icon(Icons.home,color: Colors.orange,size: 20,),
                label: 'Home',



            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_fill_on_rectangle_fill,color: Colors.grey,size: 20,),
              activeIcon:Icon(CupertinoIcons.rectangle_fill_on_rectangle_fill,color: Colors.orange,size: 20,),
              label: 'Home',
            ),

          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex,
          selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontSize: 10,color: Colors.orange),
          unselectedLabelStyle:TextStyle(fontSize: 10,color: Colors.black) ,

          iconSize: 40,

          onTap: controller.onItemTapped,
          elevation: 5
      ),
    ));

  }
  
}