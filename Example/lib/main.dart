import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'zoomer.dart';

void main() => runApp(MyApp());

// ------ Root Widget ---------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Zoomer Example",
      theme: ThemeData(
          primarySwatch: Colors.green,
          canvasColor: Colors.blue.shade100,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          platform: TargetPlatform.android),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ZoomerController _zoomerController = ZoomerController(initialScale: 1.0);
  String _zoomDetails = "Zoom";  

  @override
  Widget build(BuildContext context) {

    _zoomerController.onZoomUpdate((){
      setState(() {
        _zoomDetails = "Scale = "+ _zoomerController.scale.toStringAsFixed(2);
        _zoomDetails += "\nRotation = "+ _zoomerController.rotation.toStringAsFixed(2);
        _zoomDetails += "\nOffset = ("+ _zoomerController.offset.dx.toStringAsFixed(2)+","+_zoomerController.offset.dy.toStringAsFixed(2)+")";
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text("Zommer Example"),),
      body:
        Center(child:
        Stack(
          children: [
            Align(alignment: Alignment.topCenter,child: SizedBox(height: 150,child: Text(_zoomDetails,textAlign: TextAlign.center,style: TextStyle(fontSize: 30),))),
            Center(
              child: Zoomer(
                enableTranslation: true,
                enableRotation: true,
                clipRotation: true,
                maxScale: 2,
                minScale: 0.5,
                background:BoxDecoration(color: Colors.white),
                height: 300,
                width: 300,
                controller: _zoomerController,
                child: Container(decoration: BoxDecoration(color: Colors.green),height: 200,width: 200,child: FlutterLogo(),)),
            ),
          ])),
    );
  }
}
