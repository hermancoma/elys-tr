import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'controller/MainController.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final materialApp = new MaterialApp(
      home: getMainView(),
      theme: new ThemeData(
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      debugShowCheckedModeBanner: false,
    );
    
    return materialApp;
  }

}

Widget getMainView() {
  return new FutureBuilder<RemoteConfig>(
      future: getHomeUrl(),
      builder: (context, snapshot) {
        
        if (snapshot.hasData) {
          return getWebviewScaffold(snapshot.data);
        } else if (snapshot.hasError) {
          print("Firebase Error : ${snapshot.error}");
          return getLoadingBar();
        }

        // By default, show a loading spinner
        return new Scaffold(
          backgroundColor: Colors.blue,
          body: getLoadingBar(),
        );          
      },
    );
}

WebviewScaffold getWebviewScaffold(RemoteConfig remoteConfig) {
  return new WebviewScaffold(
      url: remoteConfig.getString('elystr_homeurl'),
      appBar: new AppBar(
        title: new Text(remoteConfig.getString('elystr_appbar_title')),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
                _onRefreshButtonPressed();
              },
            tooltip: "Refresh the App",
          )
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
    );
}

Widget getLoadingBar() {
    return new Center(
      child: new Container(
        height: 50.0,
        width: 50.0,
        decoration: new BoxDecoration(
          color: Colors.white70,
          borderRadius: new BorderRadius.circular(10.0)
        ),
        padding: new EdgeInsets.all(10.0),
        child: new CircularProgressIndicator()
      )
    );
}

_onRefreshButtonPressed() {
  _getUrl();
}

_getUrl() async {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  await remoteConfig.fetch(expiration: const Duration(hours: 12));
  await remoteConfig.activateFetched();
  flutterWebviewPlugin.launch(remoteConfig.getString('elystr_homeurl'));
}