import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  final String url;

  const NewsDetails({Key? key, required this.url}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.url);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(widget.url),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(
                '''CybeHawks Cyber Update you may be interested in ${widget.url}''',
                subject: 'CybeHawks Cyber Update you may be interested in',
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
