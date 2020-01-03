import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as ws;
import 'package:location/location.dart';
import 'package:midow/bloc/estabelecimento.dart';
import 'package:midow/bloc/favorito.dart';
import 'package:midow/model/estabelecimento.dart';
import 'dart:math';

class EstabelecimentoDetalhesPage extends ModalRoute<void> {
  Completer<GoogleMapController> _controller = Completer();
  final bloc = BlocProvider.getBloc<EstabelecimentoBloc>();
  final favoritos = BlocProvider.getBloc<FavoritoBloc>();
  final ws.DirectionsResponse direction;
  final Estabelecimento estabelecimento;
  final Map<MarkerId, Marker> marker;
  final LocationData currentLocation;
  final Set<Polyline> polilyne;
  final List<LatLng> points;
  final String mapStyle;

  EstabelecimentoDetalhesPage(
      {@required this.estabelecimento,
      @required this.currentLocation,
      @required this.direction,
      @required this.polilyne,
      @required this.mapStyle,
      @required this.points,
      @required this.marker});

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
                                  actions: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.star_border),
                                      onPressed: () {
                                        favoritos.add(estabelecimento);
                                      },
                                    ),
                                  ],
                                ),
                                body: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
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
                                                  myLocationButtonEnabled: false,
                                                  mapType: MapType.normal,
                                                  initialCameraPosition:
                                                      _kGooglePlex,
                                                  polylines: polilyne,
                                                  markers:
                                                      Set.from(marker.values),
                                                  onMapCreated:
                                                      (GoogleMapController
                                                          controller) async {
                                                    _controller
                                                        .complete(controller);
                                                    controller
                                                        .setMapStyle(mapStyle);
                                                    if (estabelecimento
                                                            .latitude <=
                                                        currentLocation
                                                            .latitude) {
                                                      await Future.delayed(
                                                          new Duration(
                                                              milliseconds:
                                                                  400));
                                                      controller.moveCamera(
                                                          CameraUpdate
                                                              .newLatLngBounds(
                                                                  getBounds(),
                                                                  70.0));
                                                    }
                                                  },
                                                ))),
                                        Container(
                                            padding: EdgeInsets.only(top: 20),
                                            width: double.infinity,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              elevation: 8,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      color: Colors.white,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text('Distância'),
                                                          Text(direction
                                                              .routes[0]
                                                              .legs[0]
                                                              .distance
                                                              .text)
                                                        ],
                                                      )),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      color: Colors.grey[100],
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text('Tempo'),
                                                          Text(direction
                                                              .routes[0]
                                                              .legs[0]
                                                              .duration
                                                              .text)
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ))
                                      ],
                                    ))))),
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
