import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';

class NewsCategoryProvider extends ChangeNotifier {
  List<NewsCategory> _categories = [];

  List<NewsCategory> get categories => _categories;

  List<CategoryWiseNews> _categoryNews = [];

  List<CategoryWiseNews> get categoryNews => _categoryNews;

  void setCategories(List<NewsCategory> categorieslist) {
    _categories = categorieslist;
    print(categories);
    notifyListeners();
  }

  void setNewsCategories(List<CategoryWiseNews> newsCategoriesList) {
    _categoryNews = newsCategoriesList;
    print(categories);
    notifyListeners();
  }
}

class NewsProviderSec1 with ChangeNotifier {
  List<NewsP> _newsList = [];

  List<NewsP> get sectionList => _newsList;

  void setProviderSec(List<NewsP> sectionList) {
    _newsList = sectionList;
    print(_newsList);
    notifyListeners();
  }
}
