import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _selectedIndex = 1;

  List<Widget> menu = [
    Row(
      children: <Widget>[
        Icon(Icons.place),
        Padding(padding: EdgeInsets.only(left: 10), child: Text('Home'))
      ],
    ),
    Row(
      children: <Widget>[
        Icon(Icons.card_travel),
        Padding(padding: EdgeInsets.only(left: 10), child: Text('Favoritos'))
      ],
    )
  ];

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    BackgroundLocation.getPermissions(
      onGranted: () {
        BackgroundLocation.startLocationService();
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
      },
    );

    BackgroundLocation.getLocationUpdates((location) async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        zoom: 15.4746,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _drawerKey,
        drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.

            child: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: menu.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(
                      height: 160,
                      child: DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FloatingActionButton(
                                disabledElevation: 0,
                                onPressed: null,
                                child: Icon(Icons.person),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            Text('Não cadastrado'),
                            Text('Clique para cadastra-se')
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ));
                } else {
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Material(
                          elevation:
                              _selectedIndex != null && _selectedIndex == index
                                  ? 2.0
                                  : 0,
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              _selectedIndex != null && _selectedIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                          child: ListTile(
                            title: menu[index - 1],
                            onTap: () {
                              _selectedIndex = index;
                              setState(() {});
                            },
                          )));
                }
              }),
        )),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              // child:
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120,
                child: AppBar(
                  leading: Transform.scale(
                      scale: 0.7,
                      child: FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.menu),
                        onPressed: () {
                          _drawerKey.currentState.openDrawer();
                        },
                      )),
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
