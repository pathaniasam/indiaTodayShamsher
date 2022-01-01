import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indiatodayshamsher/model/response/all_astro_response.dart';
import 'package:indiatodayshamsher/model/response/astro_filter.dart';
import 'package:indiatodayshamsher/screen/talktoastro/controller/talk_astro_controller.dart';
import 'package:indiatodayshamsher/utils/app_utils.dart';
import 'package:indiatodayshamsher/utils/const_strings.dart';

class AstroView extends GetView<AstroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80), child: AppUtils().appBar()),
        body: GetBuilder<AstroController>(
            init: Get.put<AstroController>(AstroController()),
            builder: (controller) {
              //controller.onInit();
              return SafeArea(
                  child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Strings.talkToAstro,
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Image.asset(
                          "assets/images/search.png",
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        PopupMenuButton<AstroFilter>(
                            icon: Image.asset(
                              "assets/images/filter.png",
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            itemBuilder: (BuildContext context) {
                              return List<PopupMenuEntry<AstroFilter>>.generate(
                                controller.fList.length,
                                (int index) {
                                  return PopupMenuItem<AstroFilter>(
                                    value: controller.fList[index],
                                    child: RadioListTile(
                                      value: controller.fList[index],
                                      groupValue: controller.selectedUser,
                                      title: Text(controller.fList[index].name
                                          .toString()),
                                      onChanged: (currentUser) {
                                        controller.setSelectedUser(
                                            currentUser as AstroFilter);
                                        Navigator.pop(context);
                                      },
                                      selected: controller.selectedUser ==
                                          controller.fList[index].name
                                              .toString(),
                                      activeColor: Colors.green,
                                    ),
                                  );
                                },
                              );
                            }

                            //

                            ),

                        PopupMenuButton<AstroFilter>(
                            icon: Image.asset(
                              'assets/images/sort.png',
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            itemBuilder: (BuildContext context) {
                              return List<PopupMenuEntry<AstroFilter>>.generate(
                                controller.languageList.length,
                                (int index) {
                                  return PopupMenuItem<AstroFilter>(
                                    value: controller.languageList[index],
                                    child: RadioListTile(
                                      value: controller.languageList[index],
                                      groupValue: controller.languageList,
                                      title: Text(controller
                                          .languageList[index].name
                                          .toString()),
                                      onChanged: (currentUser) {
                                        controller.setLanguage(
                                            currentUser as AstroFilter);
                                        Navigator.pop(context);
                                      },
                                      selected: controller.selectLanguage ==
                                          controller.languageList[index].name
                                              .toString(),
                                      activeColor: Colors.green,
                                    ),
                                  );
                                },
                              );
                            }

                            //

                            ),
                      ],
                    ),
                    Container(
                      child: Card(
                        elevation: 2,
                        child: TextField(
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(CupertinoIcons.clear),
                              onPressed: () {
                                controller.setController();
                                controller.filterSearchResults("");
                              },
                              color: Colors.black,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/search.png",
                                height: 10,
                                width: 10,
                                fit: BoxFit.contain,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white12, width: 5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0),
                            ),
                            hintText: "Search Astrologer",
                          ),
                          onChanged: (value) {
                            controller.filterSearchResults(value);
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {}
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    controller.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.data.length,
                                itemBuilder: (context, index) {
                                  return astroWidget(controller.data[index]);
                                }),
                          )
                  ],
                ),
              ));
            }));
  }

  Widget astroWidget(Data data) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: data.images!.large!.imageUrl == null
                    ? Icon(Icons.error)
                    : CachedNetworkImage(
                        imageUrl: data.images!.large!.imageUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          data.urlSlug.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )),
                        Text(
                          "${data.experience} years",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(getSkill(data.skills),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(getlangaue(data.languages),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${data.additionalPerMinuteCharges} /min",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        CupertinoIcons.phone,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      label: Text(
                        'Talk on Call',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ))
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  String getSkill(List<Skills>? skills) {
    var skill = "";
    if (skills != null) {
      skills.forEach((element) {
        skill = skill + element.name.toString() + ",";
      });
    }
    return skill;
  }

  String getlangaue(List<Languages>? languages) {
    var language = "";
    if (languages != null) {
      languages.forEach((element) {
        language = language + element.name.toString() + ",";
      });
    }
    return language;
  }
}
