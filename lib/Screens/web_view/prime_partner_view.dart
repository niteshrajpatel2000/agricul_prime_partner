// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class GoogleWebView extends StatefulWidget {
//   const GoogleWebView({super.key});
//
//   @override
//   State<GoogleWebView> createState() => _GoogleWebViewState();
// }
//
// class _GoogleWebViewState extends State<GoogleWebView> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.parse("https://prime-partner.gpcagro.in/login"),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: WebViewWidget(controller: controller)),
//     );
//   }
// }
