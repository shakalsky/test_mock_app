import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mock_app/controller/index_controller.dart';
import 'package:test_mock_app/view/pages/quiz_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  final bool showWebView;
  final String? url;

  const HomeScreen({
    super.key,
    required this.showWebView,
    required this.url,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller!.canGoBack()) {
          _controller!.goBack();
        }
        return false;
      },
      child: Consumer<IndexController>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: widget.showWebView
                ? SafeArea(
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller = webViewController;
                      },
                    ),
                  )
                : const QuizPage(),
          );
        },
      ),
    );
  }
}
