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
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    else if (Platform.isIOS) WebView.platform = SurfaceAndroidWebView();
    else if (Platform.isWindows) WebView.platform = SurfaceAndroidWebView();
    else if (Platform.isLinux) WebView.platform = SurfaceAndroidWebView();
    else if (Platform.isMacOS) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
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
                '''CybeHawks Cyber Update you may be interested in ''' +
                    widget.url,
                subject: 'CybeHawks Cyber Update you may be interested in',
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) {
                setState(() {
                  isLoaded = true;
                });
              },
              initialUrl: widget.url,
            ),
            !isLoaded
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
