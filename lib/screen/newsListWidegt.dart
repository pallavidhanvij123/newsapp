
import 'package:flutter/material.dart';

class NewsListWidget<T> extends StatelessWidget {
  final List<T> newsList;
  final Widget Function(BuildContext, T) itemBuilder;

  NewsListWidget({
    required this.newsList,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, newsList[index]);
      },
    );
  }
}
