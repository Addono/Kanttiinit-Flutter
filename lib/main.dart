import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';

import 'package:kanttiinit_flutter/areas.dart';

import 'dart:convert';
import 'dart:io';

void main() {
  // Invoke _getAreas to pre-populate the cache on app-start
  _getAreas();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home page'),
    );
  }
}

final GlobalKey<AsyncLoaderState> _asyncLoaderState = new GlobalKey<AsyncLoaderState>();

Areas _areasCache;
_asyncAreasLoader(BuildContext context) => new AsyncLoader(
  key: _asyncLoaderState,
  initState: () async => await _getAreas(),
  renderLoad: () => _areasCache != null ? _createDrawer(_areasCache, context) : new CircularProgressIndicator(),
  renderError: ([error]) => new Text('Sorry, there was an error loading'),
  renderSuccess: ({data}) => _createDrawer(data, context),
);

_createDrawer(Areas areas, BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Select area'),
          decoration: BoxDecoration(),
        ),
        ...areas.areas.map<Widget>((area) =>
            ListTile(
              title: Text(area.name),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
        )
      ],
    ),
);

_getAreas() async {
  if (_areasCache == null) {
    var httpClient = new HttpClient();
    var uri = new Uri.https(
        'kitchen.kanttiinit.fi', 'areas', {'dsOnly': '1', 'lang': 'en'});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    List areasMap = jsonDecode(responseBody);
    _areasCache = new Areas.fromJson(areasMap);
  }

  return _areasCache;
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: _asyncAreasLoader(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
