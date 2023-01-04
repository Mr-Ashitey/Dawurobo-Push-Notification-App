import 'package:flutter/material.dart';
import 'package:push_dawurobo_test/model/news_item.dart';
import 'component/news_item_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Push Notification"),
      ),
      body: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: ((_, __) => const SizedBox(height: 15)),
          itemCount: newsItems.length,
          itemBuilder: (_, index) {
            // list of news items
            return NewsItemWidget(newsItem: newsItems[index]);
          }),
    );
  }
}
