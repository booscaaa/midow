import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(10, -10),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   // child:
        //   child: Text('asdasdasd'),
        // ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Midow'),
              bottom: PreferredSize(
                child: Container(
                  color: Colors.orange,
                  height: 0,
                ),
                preferredSize: Size.fromHeight(0.0),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
