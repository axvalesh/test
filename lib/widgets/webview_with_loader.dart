import 'package:flutter/material.dart';
import 'package:test_app/services/webview_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWithLoader extends StatefulWidget {
  final String url;

  const WebViewWithLoader({super.key, required this.url});

  @override
  State<WebViewWithLoader> createState() => _WebViewWithLoaderState();
}

class _WebViewWithLoaderState extends State<WebViewWithLoader> {
  bool isLoading = true;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
     controller = WebViewInitializer.create(
      onStart: () => setState(() => isLoading = true),
      onFinish: () => setState(() => isLoading = false),
      url: widget.url
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
