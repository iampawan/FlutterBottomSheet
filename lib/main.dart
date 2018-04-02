import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 300.0,
            color: Colors.greenAccent,
            child: new Center(
              child: new Text("Hi BottomSheet"),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.greenAccent,
            child: new Center(
              child: new Text("Hi ModalSheet"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Flutter BottomSheet"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: _showPersBottomSheetCallBack,
              child: new Text("Persistent"),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            new RaisedButton(
              onPressed: _showModalSheet,
              child: new Text("Modal"),
            ),
          ],
        )),
      ),
    );
  }
}
