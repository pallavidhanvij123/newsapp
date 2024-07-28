
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/screen/newsDetail_Page.dart';
import 'package:news_app/screen/newsListWidegt.dart';

import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../provider/newscategory_provider.dart';
import '../service/news_service.dart';
import 'networkUtiliy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFirstApiCall = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _monitorConnectivity();
  }

  void _fetchData() {
    if (_isFirstApiCall) {
      NewsService.fetchNewsCategories(context);
      NewsService.fetchNewsByCategoryHeading(context);
    } else {
      NewsService.fetchNewsBySection1(context);
    }
  }

  void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _toggleApiCall(int index) {
    setState(() {
      _isFirstApiCall = index == 0;
    });
    _fetchData();
  }

  void _monitorConnectivity() {
    NetworkUtility.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showNoInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isFirstApiCall ? "English News" : "Telugu News",
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 18,
            color: theme.textTheme.bodyText1?.color,
          ),
        ),
        actions: [
          Row(
            children: [
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
              ToggleButtons(
                isSelected: [_isFirstApiCall, !_isFirstApiCall],
                onPressed: (int index) {
                  _toggleApiCall(index);
                },
                children: const [
                  Text(
                    "ENG",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "TLG",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: _isFirstApiCall
          ? Consumer<NewsCategoryProvider>(
              builder: (context, newsCategoryProvider, _) {
                return newsCategoryProvider.categoryNews.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: NewsListWidget<CategoryWiseNews>(
                          newsList: newsCategoryProvider.categoryNews,
                          itemBuilder: (context, news) {
                            return _buildNewsItem(context, news, theme);
                          },
                        ),
                      );
              },
            )
          : Consumer<NewsProviderSec1>(
              builder: (context, newsProviderSec1, _) {
                return newsProviderSec1.sectionList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: NewsListWidget<NewsP>(
                          newsList: newsProviderSec1.sectionList,
                          itemBuilder: (context, news) {
                            return _buildNewsItem(context, news, theme);
                          },
                        ),
                      );
              },
            ),
    );
  }

  Widget _buildNewsItem(BuildContext context, dynamic news, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(news.newsId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[100],
                  image: DecorationImage(
                    image: NetworkImage(news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    news.title,
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 14,
                      color: theme.textTheme.bodyText1?.color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
