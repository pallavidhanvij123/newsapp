import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:news_app/model/category_model.dart';
import 'package:news_app/provider/newscategory_provider.dart';
import 'package:provider/provider.dart';

class NewsService {
  static Future<void> fetchNewsCategories(BuildContext context) async {
    final response = await http.get(Uri.parse(
        'https://www.thehitavada.com/api/?key=245xvhw1ou3lbz1KCzl6znxxkyxzds7&getCategories'));
    print("statuscode");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      print(responseData);
      // return responseData.map((item) => NewsCategory.fromJson(item)).toList(),

      List<NewsCategory> newsCategories =
      responseData.map((data) => NewsCategory.fromJson(data)).toList();
      Provider.of<NewsCategoryProvider>(context, listen: false)
          .setCategories(newsCategories);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<void> fetchNewsByCategoryHeading(BuildContext context) async {
    final response = await http.get(Uri.parse(
        'https://www.thehitavada.com/api/?key=245xvhw1ou3lbz1KCzl6znxxkyxzds7&getNewsByMultipleCatID= 3136'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("responseData :$responseData");

      // Extracting news for each category
      List<CategoryWiseNews> categoryNews = [];
      responseData.forEach((categoryId, newsList) {
        // Check if newsList is not empty
        if (newsList != null && newsList is List) {
          // Iterate over each news item and add it to categoryNews
          categoryNews.addAll(
              newsList.map((data) => CategoryWiseNews.fromJson(data)));
        }
      });

      // Set the news categories in the provider
      Provider.of<NewsCategoryProvider>(context, listen: false)
          .setNewsCategories(categoryNews);
    } else {
      throw Exception('Failed to load news for category: ');
    }
  }

  static Future<void> fetchNewsBySection1(BuildContext context) async {
    final url = 'https://www.vsktelangana.org/api/?key=145xvgy1ou7lbz1KCzl6zuxxkyxzds2&getNewsBySection=telugu-news';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      print(jsonData);
      List<NewsP> sliderList = jsonData.map((data) => NewsP.fromJson(data))
          .toList();
      Provider.of<NewsProviderSec1>(context, listen: false).setProviderSec(
          sliderList);
    } else {
      throw Exception('Failed to load data');
    }
  }

}


