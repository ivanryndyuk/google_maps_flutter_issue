import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _mapController;
  List<Marker> _markers = List<Marker>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            _mapController.getLatLng(
              ScreenCoordinate(
                // TODO: Comment these two lines
                x: context.size.width ~/ 2.0,
                y: context.size.height ~/ 2.0,
                // TODO: Uncomment these four lines
//                x: context.size.width * MediaQuery.of(context)
//                    .devicePixelRatio ~/ 2.0,
//                y: context.size.height * MediaQuery.of(context)
//                    .devicePixelRatio ~/ 2.0,
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
