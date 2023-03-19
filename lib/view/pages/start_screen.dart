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
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url ?? 'https://www.google.com/'),
      );

    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<IndexController>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: widget.showWebView
                ? SafeArea(
                    child: WebViewWidget(controller: controller),
                  )
                : const QuizPage(),
          );
        },
      ),
    );
  }
}
