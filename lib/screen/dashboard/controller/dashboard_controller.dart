

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/model/request/panchang_request.dart';
import 'package:indiatodayshamsher/model/response/panchang_response.dart';
import 'package:indiatodayshamsher/model/response/places_response.dart';
import 'package:indiatodayshamsher/model/response/search_request.dart';
import 'package:indiatodayshamsher/respository/dio_services.dart';
import 'package:indiatodayshamsher/respository/network_utils.dart';
import 'package:indiatodayshamsher/utils/app_utils.dart';

class DashboardController extends GetxController{
  List<PlacesData> data=[];
  PanchangData? panchangdata;
  int? day;
  int? year;
  int? month;
  TextEditingController dateController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    
  }
  
  callSearch(String query){
    AppUtils().checkInternet().then((value) {
      if(value){
        SearchRequest request=SearchRequest(inputPlace: query);

        ApiHelper.get(NetworkUtils.searchLocation,params: request.toJson()).then((values) {
          PlacesResponse response=PlacesResponse.fromJson(jsonDecode(values.data));
          data.addAll(response.data!);
          update();
        }).catchError((onError){

        });
      }else{
        Get.snackbar("Connection", "Please check internet connection");

      }
    });
  }

  callPanchange(int? day,int? month,int? year,String? placeId){
    AppUtils().checkInternet().then((value) {
      if(value){
        if(day==null){
          Get.snackbar("Day", "Please select date");
          return;
        }else if(placeId==null){
          Get.snackbar("Day", "Please select Location");

        }
        PanchangRequest request=PanchangRequest(day: day,month: month,year: year,placeId: placeId);
          ApiHelper.post(NetworkUtils.searchPanchange,body: request.toJson()).then((value){
            PanchangResponse response =PanchangResponse.fromJson(jsonDecode(value!.data!));
            panchangdata=response.data;
            update();
          }).catchError((onError){

          });
      }else{
        Get.snackbar("Connection", "Please check internet connection");

      }
    });
  }

  setDate(int day,int month,int year){
    this.day=day;
    this.year=year;
    this.month=month;
    dateController.text="${day.toString().padLeft(2,"0")}/${month.toString().padLeft(2,"0")}/${year}";
    update();
  }


}