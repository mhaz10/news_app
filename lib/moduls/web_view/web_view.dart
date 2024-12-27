import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('----- Web Is Loading $progress');
          },
          onPageStarted: (String url) {
            print('----- Web IS Started $url');
          },
          onPageFinished: (String url) {
            print('----- Web IS Finished $url');
          },
        )
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}

