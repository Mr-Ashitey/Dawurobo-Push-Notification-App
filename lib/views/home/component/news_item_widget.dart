import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_links/uni_links.dart';

import '../../../model/news_item.dart';
import '../../../services/notification.dart';
import '../../home_detail.dart';

bool _initialUriIsHandled = false;

class NewsItemWidget extends StatefulWidget {
  final NewsItem newsItem;

  const NewsItemWidget({super.key, required this.newsItem});

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget> {
  StreamSubscription? _streamSubscription;

  // stream and listen on the notifications
  void _listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickNotification);
  // what to do when a notification is clicked
  void onClickNotification(String? payload) async {
    final newsItem = findByTitle(payload!);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeDetail(newsItem: newsItem)));
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _incomingLinkHandler() {
    _streamSubscription = uriLinkStream.listen((Uri? uri) async {
      if (!mounted) {
        return;
      }

      // get the path from link
      final payload = uri!.path
          .substring(1, uri.path.length - 1)
          .replaceAll(RegExp(r'_'), " ");

      // find that particular news item and open its details
      final newsItem = findByTitle(payload);
      await Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeDetail(newsItem: newsItem)));
    }, onError: (Object err) {
      if (!mounted) {
        return;
      }
      debugPrint('Error occurred: $err');
    });
  }

  Future<void> _initURIHandler() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final initialURI = await getInitialUri();
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          return;
        }

        debugPrint("Null Initial URI received");
      } on PlatformException {
        debugPrint("Failed to receive initial uri");
      } on FormatException {
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
      }
    }
  }

  @override
  void initState() {
    _initURIHandler();
    _incomingLinkHandler();

    // other usable functions for notification and deep linking
    _listenNotifications();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.newsItem.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.newsItem.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.newsItem.source,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                widget.newsItem.publishedAt,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.newsItem.description,
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    NotificationApi.showNotification(
                        title: widget.newsItem.title,
                        body: widget.newsItem.description,
                        payload: widget.newsItem.title);
                  },
                  icon: const Icon(Icons.notification_add_rounded)),
              IconButton(
                  onPressed: () {
                    final path =
                        widget.newsItem.title.replaceAll(RegExp(' '), '_');
                    Share.share('https://dawurobo12.com/$path/');
                  },
                  icon: const Icon(Icons.share))
            ],
          ),
        ],
      ),
    );
  }
}
