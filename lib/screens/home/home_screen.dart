import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreen createState() => _homeScreen();
}

class _homeScreen extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).buttonColor,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text("Apply Student Leave"),
        leading: IconButton(
          icon: const Icon(Icons.dehaze, color: Colors.white),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.drag_handle, color: Colors.white),
              onPressed: null),
        ],
      ),
      body: new Center(
        child: new Text("Welcome home!"),
      ),
    );
  }
}
