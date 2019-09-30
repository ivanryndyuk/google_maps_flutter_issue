import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _mapController;
  List<Marker> _markers = List<Marker>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(40.705875, -73.996571),
            zoom: 14.0,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onCameraIdle: () {
            if (_mapController == null) {
              return;
            }
            final devicePixelRatio = Platform.isAndroid
                ? MediaQuery.of(context).devicePixelRatio
                : 1.0;
            _mapController.getLatLng(
              ScreenCoordinate(
                // TODO: Comment these two lines for workaround
                x: context.size.width ~/ 2.0,
                y: context.size.height ~/ 2.0,
                // TODO: Uncomment these two lines for workaround
//                x: context.size.width * devicePixelRatio ~/ 2.0,
//                y: context.size.height * devicePixelRatio ~/ 2.0,
              ),
            ).then((coordinates) {
              print("center position: " + coordinates.toString());
              setState(() {
                _markers = [
                  Marker(
                    markerId: MarkerId("centerMarker"),
                    position: coordinates,
                  ),
                ];
              });
            });
          },
          markers: Set.from(_markers),
        ),
        Center(
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
