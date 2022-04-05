import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_app/select_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  var url;
  WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  double _webViewHeight = 0;
  late WebViewController _webViewController;

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController.runJavascriptReturningResult(
          "document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      child: Column(
        children: [
          Container(
            height: 60,
            width: size.width,
            color: Colors.blue,
            child: Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const SelectPage();
                    }),
                  );
                },
                // 表示アイコン
                icon: const Icon(Icons.arrow_back_ios),
                // アイコン色
                color: Colors.white,
                // サイズ
                iconSize: 30,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: _webViewHeight,
              color: Colors.white,
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) => _onPageFinished(context, url),
                onWebViewCreated: (WebViewController webViewController) async {
                  _webViewController = webViewController;
                },
                onWebResourceError: (error) {
                  print(error);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
