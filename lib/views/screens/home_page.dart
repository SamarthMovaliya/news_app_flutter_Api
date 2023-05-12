import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter_api/controller/getx_controller/image_call_getx_controller.dart';
import 'package:news_app_flutter_api/controller/helper/news_api_helper.dart';
import 'package:news_app_flutter_api/controller/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../models/news_api_model.dart';
import '../../models/resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future data;

  ImageControllerGetx imageControllerGetx = Get.put(ImageControllerGetx());

  @override
  void initState() {
    data = newsApiHelper.newsApi
        .fetchNewsData(ct: selected_ct, cou: selected_cout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: const Icon(
              Icons.sunny,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: const Icon(Icons.menu_rounded),
        centerTitle: false,
        title: Text(
          'Latest News',
          style: GoogleFonts.raleway(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: (Provider.of<ThemeProvider>(context).themeModal.isDark)
                  ? Colors.grey.shade800
                  : Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: StreamBuilder(
                            builder: (context, snapshot) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, right: 4),
                                child: GetBuilder<ImageControllerGetx>(
                                    builder: (controller) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          controller.imageModelGetx.imageData,
                                        ),
                                      ),
                                      color:
                                          (Provider.of<ThemeProvider>(context)
                                                  .themeModal
                                                  .isDark)
                                              ? Colors.grey.shade800
                                              : Colors.grey.shade100,
                                    ),
                                  );
                                }),
                              );
                            },
                          )),
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark)
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GetBuilder<ImageControllerGetx>(
                                builder: (controller) {
                                  return DropdownButton(
                                      elevation: 20,
                                      alignment: Alignment.center,
                                      dropdownColor:
                                          (Provider.of<ThemeProvider>(context)
                                                  .themeModal
                                                  .isDark)
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade100,
                                      style: TextStyle(
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                    .themeModal
                                                    .isDark)
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      icon: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.menu_open_outlined,
                                          color: Colors.grey,
                                          size: 25,
                                        ),
                                      ),
                                      isExpanded: true,
                                      underline: Container(),
                                      value: selected_cout,
                                      items: country
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e['code'],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Text(
                                                  e['name'],
                                                  style: GoogleFonts.raleway(
                                                    letterSpacing: 1,
                                                    fontSize: 22,
                                                    color: (Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .themeModal
                                                            .isDark)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          selected_cout = val.toString();
                                          data = newsApiHelper.newsApi
                                              .fetchNewsData(
                                                  ct: selected_ct,
                                                  cou: selected_cout);
                                        });
                                        controller.loadImage(
                                          img: selected_cout,
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_ct = e;
                                    data = newsApiHelper.newsApi.fetchNewsData(
                                        cou: selected_cout, ct: selected_ct);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(2, 3),
                                        blurRadius: 5,
                                        color: (selected_ct == e)
                                            ? (Provider.of<ThemeProvider>(
                                                        context)
                                                    .themeModal
                                                    .isDark)
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade400
                                            : (Provider.of<ThemeProvider>(
                                                        context)
                                                    .themeModal
                                                    .isDark)
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade300,
                                      ),
                                    ],
                                    color: (selected_ct == e)
                                        ? (Provider.of<ThemeProvider>(context)
                                                .themeModal
                                                .isDark)
                                            ? Colors.grey.shade500
                                            : Colors.white
                                        : (Provider.of<ThemeProvider>(context)
                                                .themeModal
                                                .isDark)
                                            ? Colors.grey.shade700
                                            : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 90,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: (selected_ct == e)
                                              ? (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark)
                                                  ? Colors.white
                                                  : Colors.grey.shade900
                                              : (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark)
                                                  ? Colors.grey.shade200
                                                  : Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text('error occurred ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<global>? myData = snapshot.data as List<global>;
                  return RefreshIndicator(
                    onRefresh: () {
                      data = newsApiHelper.newsApi
                          .fetchNewsData(ct: selected_ct, cou: selected_cout);
                      return Future.delayed(const Duration(seconds: 2));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 14,
                          child: ListView(
                            children: myData
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'viewPage',
                                            arguments: e);
                                      },
                                      child: Card(
                                        //const Color(0xffF1F1F1)
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                    .themeModal
                                                    .isDark)
                                                ? Colors.grey.shade700
                                                : Color(0xffF1F1F1),
                                        shadowColor: Colors.grey,
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            isThreeLine: true,
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 160,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: (Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark)
                                                            ? Colors
                                                                .grey.shade800
                                                            : Colors.blueGrey
                                                                .shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: Text(
                                                        e.sourceName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                      color: (Provider.of<
                                                                      ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark)
                                                          ? Colors.grey.shade800
                                                          : Colors
                                                              .grey.shade400,
                                                    ),
                                                    child: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            leading: Container(
                                              height: double.infinity,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(2, 3),
                                                    color: (Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .themeModal
                                                            .isDark)
                                                        ? Colors.grey.shade900
                                                        : Colors.grey.shade500,
                                                    blurRadius: 10,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    scale: 2,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                            BlendMode
                                                                .colorDodge),
                                                    image: (e.img == null)
                                                        ? const NetworkImage(
                                                            'https://timesofindia.indiatimes.com/thumb/msid-80757045,width-1200,height-900,resizemode-4/80757045.jpg')
                                                        : NetworkImage(e.img,
                                                            scale: 2)),
                                              ),
                                            ),
                                            title: Text(
                                              e.title,
                                              maxLines: 3,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.alata(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            // trailing: Container(
                                            //   height: 35,
                                            //   width: 70,
                                            //   child: Text(
                                            //     "${e.author} ...",
                                            //     style: const TextStyle(
                                            //         color: Colors.black,
                                            //         fontWeight: FontWeight.bold,
                                            //         fontSize: 10),
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
