// ignore_for_file: non_constant_identifier_names



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/Category_controller.dart';
import 'package:news_app/controller/filterList_controller.dart';
import 'package:news_app/models/news_hedlines_model.dart';
import 'package:news_app/services/services.dart';
import 'package:news_app/view/categoryscreen.dart';
import 'package:news_app/view/details_screen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

//enum FilterNewsList { bbcNews, cnnNews, aljazeeraNews }

class _mainScreenState extends State<mainScreen> {
  FilterController filterController = Get.put(FilterController());
  CategoryController categoryController = Get.put(CategoryController());

  Services services = Services();
  final format = DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryScreen()));
          },
          icon: Image.asset(
            'images/pic1.png',
            width: 25,
            height: 25,
          ),
        ),
        title: Center(
          child: Text(
            "Headlines",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        actions: [
          Obx(() => PopupMenuButton<FilterNewsList>(
              onSelected: (FilterNewsList item) {
                filterController.updateSelectedFilet(item);
              },
              initialValue: filterController.selectedFilter.value,
              itemBuilder: (context) => <PopupMenuEntry<FilterNewsList>>[
                    const PopupMenuItem<FilterNewsList>(
                        value: FilterNewsList.bbcNews, child: Text('BBC News')),
                    const PopupMenuItem<FilterNewsList>(
                        value: FilterNewsList.cnnNews, child: Text('CNN News')),
                    const PopupMenuItem<FilterNewsList>(
                        value: FilterNewsList.aljazeeraNews,
                        child: Text('Aljazeera News')),
                  ]))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            
            SizedBox(
                height: height * 0.84 ,
                width: width,
                
                child: Obx(
                  () => FutureBuilder(
                      future: Services.getbbcheadlinesapi(
                          filterController.name.value),
                      builder: (context,
                          AsyncSnapshot<News_headlines_model> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitDualRing(
                              color: Colors.blue,
                              size: 50,
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error to fetch data',
                              style: GoogleFonts.anton(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection:
                                  axisDirectionToAxis(AxisDirection.down),
                              itemCount: snapshot.data!.articles!.length,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateTime.parse(snapshot
                                    .data!.articles![index].publishedAt
                                    .toString());
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailsScreen(
                                                  author: snapshot.data!
                                                      .articles![index].author
                                                      .toString(),
                                                  content: snapshot.data!
                                                      .articles![index].content
                                                      .toString(),
                                                  description: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .description
                                                      .toString(),
                                                  publishedAt: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString(),
                                                  title: snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  urlToImage: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString(),
                                                )));
                                  },
                                  child: SizedBox(
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        SizedBox(
                                          height: height * 0.65,
                                          width: width * 0.9,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 14),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!
                                                    .articles![index].urlToImage
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: height * 0.05,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height * 0.22,
                                              width: width * 0.75,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(snapshot.data!
                                                        .articles![index].title
                                                        .toString()),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .source!
                                                              .name
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: Colors
                                                                          .purple[
                                                                      900]),
                                                        ),
                                                        Text(format
                                                            .format(dateTime))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                )),
            const SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    );
  }
}
