import 'dart:async';
import 'dart:ui';
import 'package:background_fetch/background_fetch.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_util/google_maps_util.dart';
import 'package:location/location.dart';
import 'package:midow/api/directions.dart';
import 'package:midow/api/estabelecimento.dart';
import 'package:midow/bloc/estabelecimento.dart';
import 'dart:math' as math;

import 'package:midow/model/estabelecimento.dart';
import 'package:midow/screen/crud-estabelecimento.dart';
import 'package:midow/screen/detalhes-estabelecimento.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final bloc = BlocProvider.getBloc<EstabelecimentoBloc>();

  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  AnimationController _controllerAnimation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool firstTime = true;
  MarkerId selectedMarker;
  LatLng markerAdd;
  bool cadastrar = false;
  LocationData currentLocation;
  EstabelecimentoAPI api = EstabelecimentoAPI();

  var location = new Location();

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
    initPlatformState();
    _getLocation();
    _listenLocation();
    bloc.index();

    bloc.estabelecimentos.stream.listen(_plotMaps);

    _controllerAnimation = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  _plotMaps(List<Estabelecimento> estabelecimentos) {
    for (Estabelecimento e in estabelecimentos) {
      _add(e);
    }
  }

  _getLocation() async {
    try {
      currentLocation = await location.getLocation();
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.4746,
      )));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // error = 'Permission denied';
      }
      currentLocation = null;
    }
  }

  _listenLocation() {
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      currentLocation = currentLocation;
      print(currentLocation);
    });
  }

  bool _enabled = true;
  int _status = 0;
  bool nova = false;
  List<DateTime> _events = [];
  List<IconData> icons = [Icons.info, Icons.add];

  Future<void> initPlatformState() async {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_NONE),
        () async {
      print('[BackgroundFetch] Event received');
      setState(() {
        _events.insert(0, new DateTime.now());
      });

      BackgroundFetch.finish();
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });
    if (!mounted) return;
  }

  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
    }
  }

  _add(Estabelecimento e) async {
    final bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/marker_point.png');
    final String markerIdVal = e.id.toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    if (markers.containsKey(markerId)) {
      markers.remove(markerId);
    }

    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(e.latitude, e.longitude),
        icon: bitmapIcon,
        onTap: () async {
          DirectionsAPI api = new DirectionsAPI();
          print('asdasdasdasd');
          print(await api.getRoute(currentLocation, e));

          Set<Polyline> _polyline = {};
          List<LatLng> latLong = new PolyUtil().decode(await api.getRoute(currentLocation, e));

          _polyline.add(Polyline(
            polylineId: PolylineId(e.id.toString()),
            visible: true,
            
            //latlng is List<LatLng>
            points: latLong,
                
            color: Theme.of(context).primaryColor,
          ));

          Navigator.of(context).push(EstabelecimentoDetalhesPage(
              estabelecimento: e,
              currentLocation: currentLocation,
              polilyne: _polyline,
              points: latLong));
        });
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    return new Scaffold(
      key: _drawerKey,
      drawer: Drawer(
          child: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: menu.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                    onDoubleTap: () {
                      _onClickEnable(true);
                    },
                    child: SizedBox(
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
                              Text('Clique para cadastrar-se')
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        )));
              } else {
                return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Material(
                        elevation:
                            _selectedIndex != null && _selectedIndex == index
                                ? 2.0
                                : 0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: _selectedIndex != null && _selectedIndex == index
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
          // Consumer<EstabelecimentoBloc>(
          //     builder: (BuildContext context, EstabelecimentoBloc bloc) {
          //   this.markers = <MarkerId, Marker>{};
          //   for (Estabelecimento e in bloc.estabelecimentos) {
          //     _add(e);
          //   }

          //   return Container();
          // }),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              // child:
              child: GoogleMap(
                minMaxZoomPreference: MinMaxZoomPreference(13, 18),
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: Set<Marker>.of(markers.values),
                onCameraMoveStarted: () {
                  this.cadastrar = true;
                  setState(() {});
                },
                onCameraMove: (object) {
                  if (nova) {
                    markerAdd = object.target;
                    setState(() {});
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              child: AppBar(
                centerTitle: false,
                leading: Transform.scale(
                    scale: 0.8,
                    child: FloatingActionButton(
                      elevation: 1,
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
          ),
          nova
              ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('images/marker.png'),
                          ))),
                )
              : Container()
        ],
      ),
      floatingActionButton: !this.nova
          ? new Column(
              mainAxisSize: MainAxisSize.min,
              children: new List.generate(icons.length, (int index) {
                Widget child = new Container(
                  height: 70.0,
                  width: 56.0,
                  alignment: FractionalOffset.topCenter,
                  child: new ScaleTransition(
                    scale: new CurvedAnimation(
                      parent: _controllerAnimation,
                      curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                          curve: Curves.easeOut),
                    ),
                    child: new FloatingActionButton(
                      elevation: 8,
                      heroTag: null,
                      backgroundColor: backgroundColor,
                      mini: true,
                      child: new Icon(
                        icons[index],
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      onPressed: () async {
                        switch (index) {
                          case 1:
                            this.nova = true;
                            this.cadastrar = false;
                            _controllerAnimation.reverse();
                            setState(() {});
                            break;

                          default:
                        }
                      },
                    ),
                  ),
                );
                return child;
              }).toList()
                ..add(
                  new FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    heroTag: null,
                    child: new AnimatedBuilder(
                      animation: _controllerAnimation,
                      builder: (BuildContext context, Widget child) {
                        return new Transform(
                          transform: new Matrix4.rotationZ(
                              _controllerAnimation.value * 0.5 * math.pi),
                          alignment: FractionalOffset.center,
                          child: new Icon(_controllerAnimation.isDismissed
                              ? Icons.share
                              : Icons.close),
                        );
                      },
                    ),
                    onPressed: () {
                      if (_controllerAnimation.isDismissed) {
                        _controllerAnimation.forward();
                      } else {
                        _controllerAnimation.reverse();
                      }
                    },
                  ),
                ),
            )
          : Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  cadastrar
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text('Incluir nesse local'),
                            onPressed: () {
                              this.nova = !this.nova;
                              this.cadastrar = false;

                              setState(() {});

                              Estabelecimento e = new Estabelecimento(
                                  latitude: markerAdd.latitude,
                                  longitude: markerAdd.longitude);
                              Navigator.of(context).push(
                                  EstabelecimentoCrudPage(estabelecimento: e));
                              // Add Your Code here.
                            },
                          ),
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Cancelar'),
                      onPressed: () {
                        this.cadastrar = false;
                        this.nova = !this.nova;
                        this.markers = <MarkerId, Marker>{};
                        setState(() {});
                      },
                    ),
                  ),
                ],
              )),
      floatingActionButtonAnimator: NoScalingAnimation(),
      floatingActionButtonLocation: this.nova
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }

  // void _remove() {
  //   setState(() {
  //     if (markers.containsKey(selectedMarker)) {
  //       markers.remove(selectedMarker);
  //     }
  //   });
  // }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  double _x;
  double _y;
  @override
  Offset getOffset({Offset begin, Offset end, double progress}) {
    _x = begin.dx + (end.dx - begin.dx) * progress;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x, _y);
  }

  @override
  Animation<double> getRotationAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
