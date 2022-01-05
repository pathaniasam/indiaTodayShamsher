import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:indiatodayshamsher/utils/app_colors.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static final AppUtils _singleton = AppUtils._internal();

  factory AppUtils() {
    return _singleton;
  }

  AppUtils._internal();

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


  static void Snackbar(title, message) {
    Get.snackbar(title, message,
        colorText: Colors.white, backgroundColor: AppColors.blue);
  }

  static TextStyle customTextStyle({double? fontSize, color, fontWeight}) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  Widget appBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/hamburger.png",
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            Image.asset(
              "assets/images/logo.png",
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
            Image.asset(
              "assets/images/profile.png",
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  String getDateComplete(String? date) {
    // DateTime tempDate = new DateFormat("yyyy-MMM-ddTHH:mm:ss").parse(date);
    if (date == null) {
      return "";
    }
    var outputDate = "";
    try {
      DateTime parseDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd.MM.yyyy');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {}
    return outputDate;
  }

  Future<DateTime?> getDate(BuildContext context) async {
    return await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: new DateTime(1980),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2023),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.blue,
                onSurface: Colors.grey,
              ),
              dialogBackgroundColor: Colors.white.withOpacity(1),
            ),
            child: child ?? SizedBox(),
          );
        }).then((picked) {
      if (picked != null)
        return picked;
      else
        return null;
    });
  }
}
