class NewsCategory {
  final int id;
  final String name;

  NewsCategory({required this.id, required this.name});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json['DcategoryId'],
      name: json['DcategoryName'],
    );
  }
}

class CategoryWiseNews {
  final int id;
  final int newsId;
  final String title;
  final String imageUrl;
  final String categoryName;

  CategoryWiseNews(
      {required this.id,
      required this.newsId,
      required this.title,
      required this.imageUrl,
      required this.categoryName});

  factory CategoryWiseNews.fromJson(Map<String, dynamic> json) {
    return CategoryWiseNews(
      id: json['dCategoryID'],
      newsId: json['NewsId'],
      title: json['NewsTitle'],
      imageUrl: '${json['ServerPrefix']}${json['ImageURL']}',
      categoryName: json['categoryName'],
    );
  }
}

class NewsP {
  final int newsId;
  final String title;
  final String imageUrl;
  final String categoryName;

  NewsP({
    required this.newsId,
    required this.title,
    required this.imageUrl,
    required this.categoryName,
  });

  factory NewsP.fromJson(Map<String, dynamic> json) {
    return NewsP(
        newsId: json['NewsId'],
        title: json['NewsTitle'] ?? "",
        imageUrl: '${json['ServerPrefix']}${json['ImageURL']}',
        categoryName: json['CategoryName']);
  }
}

class News {
  String image;
  String newsTitle;
  String newsIntroText;
  String newsPlainText;
  String categoryName;

  News(
      {required this.image,
      required this.newsTitle,
      required this.newsIntroText,
      required this.newsPlainText,
      required this.categoryName});

  // Add a factory method to convert JSON to a News object
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        image: json['Image'],
        newsTitle: json['NewsTitle'],
        newsIntroText: json['NewsIntroText'],
        newsPlainText: json['NewsPlainText'],
        categoryName: json['CategoryName']);
  }
}
