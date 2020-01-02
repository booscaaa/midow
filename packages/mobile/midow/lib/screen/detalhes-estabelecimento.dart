import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:midow/bloc/estabelecimento.dart';
import 'package:midow/model/estabelecimento.dart';
import 'dart:math';

class EstabelecimentoDetalhesPage extends ModalRoute<void> {
  final Estabelecimento estabelecimento;
  final LocationData currentLocation;
  final Set<Polyline> polilyne;
  final List<LatLng> points;
  EstabelecimentoDetalhesPage(
      {this.estabelecimento, this.currentLocation, this.polilyne, this.points});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  final bloc = BlocProvider.getBloc<EstabelecimentoBloc>();

  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 18,
    );
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
            bottom: false,
            top: true,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(30.0),
                                topRight: const Radius.circular(30.0))),
                        child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              appBar: AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                title: Text(estabelecimento.nome),
                                iconTheme: IconThemeData(
                                    color: Theme.of(context).primaryColor),
                              ),
                              body: Consumer<EstabelecimentoBloc>(builder:
                                  (BuildContext context,
                                      EstabelecimentoBloc bloc) {
                                if (bloc.loading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Stack(
                                    children: <Widget>[
                                      Positioned(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          // child:
                                          child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  elevation: 8,
                                                  child: GoogleMap(
                                                    zoomGesturesEnabled: true,
                                                    myLocationEnabled: true,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    mapType: MapType.normal,
                                                    initialCameraPosition:
                                                        _kGooglePlex,
                                                    polylines: polilyne,
                                                    markers: Set<Marker>.of(
                                                        markers.values),
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) async {
                                                      _controller
                                                          .complete(controller);
                                                      await Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  500));
                                                      if (estabelecimento
                                                              .latitude <=
                                                          currentLocation
                                                              .latitude) {
                                                        controller.moveCamera(
                                                          CameraUpdate.newLatLngBounds(
                                                              LatLngBounds(
                                                                  southwest: LatLng(
                                                                      estabelecimento
                                                                          .latitude,
                                                                      estabelecimento
                                                                          .longitude),
                                                                  northeast: LatLng(
                                                                      currentLocation
                                                                          .latitude,
                                                                      currentLocation
                                                                          .longitude)),
                                                              20.0),
                                                        );
                                                      } else {
                                                        controller.moveCamera(
                                                            CameraUpdate
                                                                .newLatLngBounds(
                                                                    getBounds(),
                                                                    20.0));
                                                      }
                                                    },
                                                  )))),
                                    ],
                                  );
                                }
                              }),
                            ))),
                  ),
                )
              ],
            )));
  }

  LatLngBounds getBounds() {
    var lngs = points.map<double>((m) => m.longitude).toList();
    var lats = points.map<double>((m) => m.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  _add(Estabelecimento e) async {
    final bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/marker_point.png');
    final String markerIdVal = e.id.toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(e.latitude, e.longitude),
        icon: bitmapIcon);
    print('asdasdas');
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(
          new CurvedAnimation(parent: animation, curve: Curves.easeInBack)),
      child: child,
    );
  }
}
