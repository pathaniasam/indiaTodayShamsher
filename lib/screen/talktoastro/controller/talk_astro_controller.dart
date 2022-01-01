import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/model/response/all_astro_response.dart';
import 'package:indiatodayshamsher/model/response/astro_filter.dart';
import 'package:indiatodayshamsher/respository/dio_services.dart';
import 'package:indiatodayshamsher/respository/network_utils.dart';
import 'package:indiatodayshamsher/utils/app_utils.dart';

class AstroController extends GetxController {
  List<Data> data = [];
  bool isLoading = true;
  int id = 0;
  var items = <Data>[];
  var duplicateItems = <Data>[];

  TextEditingController searchController = TextEditingController();

  List<AstroFilter> fList = [
    AstroFilter(
      index: 1,
      name: "Experience- high to low",
    ),
    AstroFilter(
      index: 2,
      name: "Experience- low to high",
    ),
    AstroFilter(
      index: 3,
      name: "Price- high to low",
    ),
    AstroFilter(
      index: 4,
      name: "Price- low to high",
    ),
  ];
  List<AstroFilter> languageList = [
    AstroFilter(
      index: 1,
      name: "Hindi to English",
    ),
    AstroFilter(
      index: 2,
      name: "English to hindi",
    ),
  ];
  AstroFilter? selectedUser;
  AstroFilter? selectLanguage;

  setSelectedUser(AstroFilter user) {
    selectedUser = user;
    sortList(user.index);
    update();
  }

  setLanguage(AstroFilter user) {
    selectLanguage = user;
    sortListlanguage(user.index);
    // update();
  }

  @override
  void onInit() {
    super.onInit();
    getAstroList();
  }

  void getAstroList() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        ApiHelper.get(NetworkUtils.getAllAstro).then((values) {
          AllAstroReposne response =
              AllAstroReposne.fromJson(jsonDecode(values.data));
          data.addAll(response.data!);
          duplicateItems.addAll(data);
          isLoading = false;
          update();
        }).catchError((onError) {
          print("error");
        });
      } else {
        Get.snackbar("Connection", "Please check internet connection");
      }
    });
  }

  void sortList(int? index) {
    if (index == 1) {
      data.sort(
          (a, b) => b.experience!.toInt().compareTo(a.experience!.toInt()));
    } else if (index == 2) {
      data.sort(
          (a, b) => a.experience!.toInt().compareTo(b.experience!.toInt()));
    } else if (index == 3) {
      data.sort((a, b) => b.additionalPerMinuteCharges!
          .toInt()
          .compareTo(a.additionalPerMinuteCharges!.toInt()));
    } else if (index == 4) {
      data.sort((a, b) => a.additionalPerMinuteCharges!
          .toInt()
          .compareTo(b.additionalPerMinuteCharges!.toInt()));
    }
  }

  void filterSearchResults(String query) {
    List<Data> dummySearchList = <Data>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Data> dummyListData = <Data>[];
      dummySearchList.forEach((item) {
        if (item.urlSlug.toString().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        var contain = item.skills!.where((element) => element.name == query);

        if (contain.isNotEmpty) {
          dummyListData.add(item);
        }

      });

      data.clear();
      data.addAll(dummyListData);
      print("total data" + data.toString());
      update();
      return;
    } else {
      data.clear();
      data.addAll(duplicateItems);
      update();
    }
  }

  sortListlanguage(int? index) {
    if (index == 1) {
      data.sort(
          (a, b) => a.languages!.join("").compareTo(b.languages!.join("")));

      update();
    } else if (index == 2) {
      data.sort(
          (a, b) => b.languages!.join("").compareTo(a.languages!.join("")));
    }
    update();
  }

  setController() {
    searchController.text = "";
    update();
  }
}
