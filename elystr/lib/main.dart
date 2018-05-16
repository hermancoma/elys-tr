import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final webURL = "https://cms-mall-staging.elys.id/";
    final webView = new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: webURL,
              appBar: new AppBar(
                title: new Text("Elys - TR"),
              ),
              withZoom: true,
              withLocalStorage: true,
            )
      },
      theme: new ThemeData(
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
    );
    return webView;
  }
}