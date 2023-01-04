import 'package:flutter/material.dart';

import '../model/news_item.dart';

class HomeDetail extends StatelessWidget {
  final NewsItem? newsItem;

  const HomeDetail({super.key, this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem!.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(newsItem!.imageUrl),
            const SizedBox(height: 16),
            Text(
              newsItem!.description,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16),
            Text(
              'Source: ${newsItem!.source}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Published at: ${newsItem!.publishedAt}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
