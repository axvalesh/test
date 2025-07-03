import 'dart:ui';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewInitializer {
  static WebViewController create({
    required VoidCallback onStart,
    required VoidCallback onFinish,
    required String url,
  }) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => onStart(),
          onPageFinished: (_) => onFinish(),
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
