import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

import 'dart:ui' as ui;
import '../model/category_model.dart';
import 'HomePage.dart';

import 'package:intl/intl.dart';

class NewsDetailPage extends StatefulWidget {
  var newsCategoriesId;

  // var newsSliderIds;

  NewsDetailPage(this.newsCategoriesId, {Key? key}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  var newsId;
  var sliderId;
  String? userId;
  int? newsCategoryId;

  String? newsIntroText;
  String? newsPlainText;

  String? image;
  String? newsTitle;
  String? date;
  String? categoryName;
  String? newsUrl;
  bool isLoading = false;

  bool isFavorite = false;
  bool isShare = false;
  List<dynamic> dataList = [];
  List<String> paragraphs = [];

  @override
  initState() {
    super.initState();
    // futureNewsPageApiResponse = ApiService.fetchNewsPageApiAdsResponse();
    print("enter slider page ");
    // print(widget.newsCategoriesId);
    dataList = [];
    newsCategoryId = widget
        .newsCategoriesId; // Assuming widget.newsCategoriesId is of type int
    newsId = newsCategoryId.toString();
    // newsId = widget.newsCategoriesId;
    // sliderId = widget.newsSliderIds;
    print("newsId :$newsId");
    newsIdApi();
    // accessToken('');
  }

  Future<void> newsIdApi() async {
    setState(() {
      isLoading = true;
    });

    print("newsCategoryId: $newsCategoryId");
    final response = await http.get(
      Uri.parse(
          'https://www.thehitavada.com/api/?key=245xvhw1ou3lbz1KCzl6znxxkyxzds7&getNewsByID=$newsCategoryId'),
      headers: {},
    );

    if (response.statusCode == 200) {
      setState(() {
        var responseData = response.body;
        Map<String, dynamic> jsonData = json.decode(responseData);
        dataList = jsonData['data'];
        // print(dataList);
        // print(responseData);
        List<dynamic> data = jsonData['data'];
        Map<String, dynamic> newsItem = data[0];
        Map<String, dynamic> newsDate = newsItem['NewsDate'];

        // Extract and format the date
        String dateString = newsDate['date'];
        DateTime dateTime = DateTime.parse(dateString);
        date = DateFormat('d MMM y').format(dateTime);

        for (var item in dataList) {
          categoryName = item['CategoryName'];
          newsUrl = item['NewsURL'];
          isLoading = false;
          String newsPlainText1 = item['NewsPlainText'];
          newsPlainText =
              newsPlainText1.replaceAll(RegExp(r'\\r\\n|&#nbsp;[1-9]|10'), '');
          newsPlainText =
              newsPlainText1.replaceAll("\r\n\r\n\r\n\r\n&nbsp;[1-9]|10", "");
          // // Remove leading and trailing spaces
          newsPlainText = newsPlainText1.trim();

          News news = News.fromJson(item);

          setState(() {
            image = news.image;
            newsTitle = news.newsTitle;
            newsIntroText = news.newsIntroText;
            categoryName = news.categoryName;
          });

          paragraphs = newsPlainText1.split(". ");
        }
      });
      setState(() {
        isLoading = false;
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: false,
        leading: null,
        automaticallyImplyLeading: false,
        // Ensures no space is reserved for the leading widget
        titleSpacing: 0.0,
        // Removes the default space between leading and title
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                // color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false, // Aligns the row to the start
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SingleChildScrollView(
              child: Container(
                // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    // NewsPageAdsWidget(futureNewsPageApiResponse: futureNewsPageApiResponse, index: 1),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "$newsTitle",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$date",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Serif',
                              // color: Colors.grey[700],
                            ),
                          ),
                          // Spacer(),
                          // SizedBox(
                          //   width: 80,
                          // ),
                          Container(
                            height: 30,
                            color: Colors.red[400],
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "$categoryName",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Serif',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Image.network(
                          '$image',
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var paragraph in paragraphs)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              paragraph,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Serif',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
