import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/model/response/panchang_response.dart';
import 'package:indiatodayshamsher/model/response/places_response.dart';
import 'package:indiatodayshamsher/screen/dashboard/controller/dashboard_controller.dart';
import 'package:indiatodayshamsher/screen/talktoastro/controller/talk_astro_controller.dart';
import 'package:indiatodayshamsher/utils/app_utils.dart';
import 'package:indiatodayshamsher/utils/const_strings.dart';

class DashBoardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), child: AppUtils().appBar()),
      body: SafeArea(
        child: GetBuilder<DashboardController>(
            init: Get.put<DashboardController>(DashboardController()),
            builder: (controller) {
              //controller.onInit();
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.back,
                            color: Colors.black,
                          ),
                          Text(
                            Strings.dailyPanchang,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),

                        child: Text(
                          Strings.dailyPanchangTitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                   Container(
                     margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                     color: Colors.orange.withAlpha(60),
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         children: [
                           Row(
                             children: [
                               Expanded(
                                   flex:2,

                                   child: Text(Strings.dates)),
                               Expanded(
                                 flex: 6,
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                     child: TextField(
controller: controller.dateController,
                                       enableInteractiveSelection: false,
                                       decoration: InputDecoration(
                                         fillColor: Colors.white,
                                           border: InputBorder.none,
                                         suffixIcon: Icon(CupertinoIcons.arrowtriangle_down_fill,color: Colors.black,size: 20,)
                                       ),
                                       cursorColor: Colors.black,


                                       onTap: () {
                                         FocusScope.of(context)
                                             .requestFocus(new FocusNode());
                                         AppUtils().getDate(context).then((value) {
                                           if (value != null) {
                                             print(
                                                 "${"Date" + value.day.toString()}${"month" + value.month.toString()}${"year" + value.year.toString()}");
                                             controller.setDate(
                                                 value.day, value.month, value.year);
                                             // dateOfBirthController.text = value;
                                           }
                                         });
                                       },
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           SizedBox(height: 8,),
                           Row(
                             children: [
                               Expanded(
                                 flex:2,
                                   child: Text(Strings.location)),
                               Expanded(
                                 flex: 6,
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: Autocomplete<PlacesData>(
                                     optionsBuilder: (TextEditingValue textEditingValue) {
                                       if ((textEditingValue != null) &&
                                           (textEditingValue.text != null) &&
                                           textEditingValue.text.length > 2) {
                                         controller.callSearch(textEditingValue.text);
                                         return controller.data
                                             .where((PlacesData userRec) =>
                                             userRec.placeName!.toLowerCase().contains(
                                                 textEditingValue.text.toLowerCase()))
                                             .toList();
                                       } else {
                                         return const Iterable<PlacesData>.empty();
                                       }
                                     },
                                     displayStringForOption: (PlacesData option) =>
                                     option.placeName!,
                                     fieldViewBuilder: (BuildContext context,
                                         TextEditingController fieldTextEditingController,
                                         FocusNode fieldFocusNode,
                                         VoidCallback onFieldSubmitted) {
                                       return Container(
                                         padding: EdgeInsets.only(left: 5,right: 5),
                                         child: TextField(
                                           controller: fieldTextEditingController,

                                           focusNode: fieldFocusNode,

                                           decoration: InputDecoration(
                                             border: InputBorder.none,

                                           ),
                                           style:
                                           const TextStyle(fontSize: 12),
                                         ),
                                       );
                                     },
                                     onSelected: (PlacesData selection) {
                                       controller.callPanchange(
                                           controller.day,
                                           controller.month,
                                           controller.year,
                                           selection.placeId!);
                                     },
                                     optionsViewBuilder: (BuildContext context,
                                         AutocompleteOnSelected<PlacesData> onSelected,
                                         Iterable<PlacesData> options) {
                                       return Align(
                                         alignment: Alignment.topLeft,
                                         child: Material(
                                           child: Container(
                                             width: 250.00,
                                             child: ListView.builder(
                                               padding: EdgeInsets.all(10.0),
                                               itemCount: options.length,
                                               itemBuilder:
                                                   (BuildContext context, int index) {
                                                 final PlacesData option =
                                                 options.elementAt(index);
                                                 return ListTile(
                                                   onTap: () {
                                                     print("Click here");
                                                     onSelected(option);
                                                   },
                                                   title: Container(
padding: EdgeInsets.only(left: 5,right: 5),
                                                     child: Text(option.placeName!,
                                                         style: const TextStyle(
                                                             color: Colors.black)),
                                                   ),
                                                 );
                                               },
                                             ),
                                           ),
                                         ),
                                       );
                                     },
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                      controller.panchangdata != null
                          ? Column(
                            children: [
                              panchangdataWidget(
                                  "Tithi",
                                  "Tithi Number",
                                  controller
                                      .panchangdata!.tithi!.details!.tithiNumber
                                      .toString(),
                                  "Tithi Name:",
                                  controller
                                      .panchangdata!.tithi!.details!.tithiName!,
                                  "Special:",
                                  controller
                                      .panchangdata!.tithi!.details!.special!,
                                  "Summary",
                                  controller
                                      .panchangdata!.tithi!.details!.summary!,
                                  "Deity",
                                  controller
                                      .panchangdata!.tithi!.details!.deity!,
                                  "End Time",
                                  controller.panchangdata!.tithi!.endTime!),
                              panchangdataWidget(
                                  "Nakshatra",
                                  "Nakshatra Number",
                                  controller.panchangdata!.nakshatra!.details!
                                      .nakNumber
                                      .toString(),
                                  "Nakshatra Name:",
                                  controller
                                      .panchangdata!.nakshatra!.details!.nakName
                                      .toString(),
                                  "Ruler:",
                                  controller
                                      .panchangdata!.nakshatra!.details!.ruler!,
                                  "Deity",
                                  controller
                                      .panchangdata!.nakshatra!.details!.deity!,
                                  "Summary",
                                  controller.panchangdata!.nakshatra!.details!
                                      .summary!,
                                  "End Time",
                                  controller.panchangdata!.tithi!.endTime!),
                              panchangdataWidget(
                                  "Yog",
                                  "Yog Number:",
                                  controller.panchangdata!.nakshatra!.details!
                                      .nakNumber
                                      .toString(),
                                  "Yog Name:",
                                  controller.panchangdata!.yog!.details!.yogName
                                      .toString(),
                                  "Meaning:",
                                  controller
                                      .panchangdata!.yog!.details!.meaning!,
                                  "Special:",
                                  controller
                                      .panchangdata!.yog!.details!.special!,
                                  "",
                                  "",
                                  "End Time",
                                  controller.panchangdata!.yog!.endTime!),
                              panchangdataWidget(
                                  "Karan",
                                  "Karan Number",
                                  controller
                                      .panchangdata!.karan!.details!.karanNumber
                                      .toString(),
                                  "Karan Name:",
                                  controller
                                      .panchangdata!.karan!.details!.karanName
                                      .toString(),
                                  "Special:",
                                  controller
                                      .panchangdata!.karan!.details!.special!,
                                  "deity:",
                                  controller
                                      .panchangdata!.karan!.details!.deity!,
                                  "",
                                  "",
                                  "End Time:",
                                  controller.panchangdata!.karan!.endTime!),
                            ],
                          )
                          : Container()
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget panchangdataWidget(
      String title,
      String number,
      String tithiNumber,
      String name,
      String tithiName,
      String special,
      String specialName,
      String summary,
      String summaryTitle,
      String deity,
      String deityName,
      String endTime,
      EndTime endName) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(title,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(

              child: Text(number,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),)),

            Expanded(child: Text(tithiNumber,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),))],
        ),
        Row(
          children: [Expanded(

      child: Text(name,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300))),

            Expanded(child: Text(tithiName,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300)))],
        ),
        Row(
          children: [Expanded(
           child: Text(special,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300))),
           Expanded( child: Text(specialName,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300)))],
        ),
        Row(
          children: [Expanded(child: Text(summary,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300))),
        Expanded( child: Text(summaryTitle,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300)))],
        ),
        Row(
          children: [
            Expanded(

                child: Text(deity,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300))),
            Expanded( child: Text(deityName,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300)))],
        ),
        Row(

          children: [
            Expanded(

                child: Text("End Time",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300))),

            Expanded(

                child: Text(
                    "${endName.hour!.toString()} hour ${endName.minute.toString()} minute ${ endName.second!.toString()} second",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300)))
          ],
        ),
      ]),
    );
  }
}
