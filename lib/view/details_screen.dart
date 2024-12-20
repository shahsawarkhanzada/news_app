// ignore_for_file: must_be_immutable



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/services/services.dart';

class NewsDetailsScreen extends StatefulWidget {
  String author, title, description, urlToImage, publishedAt, content;
  NewsDetailsScreen(
      {super.key,
      required this.author,
      required this.content,
      required this.description,
      required this.publishedAt,
      required this.title,
      required this.urlToImage});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  Services service = Services();
  final format = DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    DateTime dateTime = DateTime.parse(widget.publishedAt);
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              height: height * 0.45,
              child: CachedNetworkImage(
                imageUrl: widget.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              padding:  EdgeInsets.only(top: height * 0.06, right: 20, left: 20),
              margin: EdgeInsets.only(top: height * 0.33),
              height: height * 0.6,
              child: ListView(
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.author,
                        style: TextStyle(color: Colors.blue[400]),
                      ),
                      Text(
                        format.format(dateTime),
                        style: TextStyle(color: Colors.blue[400]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ));
  }
}
