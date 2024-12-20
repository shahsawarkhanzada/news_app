import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/Category_controller.dart';
import 'package:news_app/models/news_categories_model.dart';
import 'package:news_app/services/services.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());

  final format = DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
              width: width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              {
                                categoryController.category.value =
                                    categoryController.categoryList[index]
                                        .toString();
                              }
                            },
                            child: Container(
                              height: height * 0.05,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: categoryController.category.value ==
                                          categoryController.categoryList[index]
                                      ? Colors.grey
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: Text(categoryController
                                      .categoryList[index]
                                      .toString())),
                            ),
                          ),
                        ));
                  }),
            ),
            Expanded(
                child: Obx(
              () => FutureBuilder<NewsCategoryModel>(
                  future: Services.News_category_api(
                      categoryController.category.value),
                  builder:
                      (context, AsyncSnapshot<NewsCategoryModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitDualRing(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'Snapshot Has no data',
                          style: GoogleFonts.anton(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error',
                          style: GoogleFonts.anton(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles[index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles[index].urlToImage
                                          .toString(),
                                      fit: BoxFit.fill,
                                      height: height * 0.16,
                                      width: width * 0.35,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'images/No-image-found.jpg',
                                        fit: BoxFit.fill,
                                        height: height * 0.16,
                                        width: width * 0.35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: Container(
                                      height: height * 0.152,
                                      width: 0.6,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.articles[index].title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data!
                                                        .articles[index]
                                                        .source
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.blue[400])),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.blue[400]),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
