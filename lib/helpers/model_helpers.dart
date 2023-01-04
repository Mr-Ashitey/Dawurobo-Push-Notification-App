// helper function to find a news item by matching titles
import '../model/news_item.dart';

NewsItem findByTitle(String title) =>
    newsItems.firstWhere((newsItem) => newsItem.title == title);
