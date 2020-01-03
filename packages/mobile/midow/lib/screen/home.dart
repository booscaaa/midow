import 'dart:async';
import 'dart:ui';
import 'package:background_fetch/background_fetch.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_util/google_maps_util.dart';
import 'package:google_maps_webservice/directions.dart' as ws;
import 'package:location/location.dart';
import 'package:midow/api/directions.dart';
import 'package:midow/api/estabelecimento.dart';
import 'package:midow/bloc/estabelecimento.dart';
import 'dart:math' as math;

import 'package:midow/model/estabelecimento.dart';
import 'package:midow/screen/crud-estabelecimento.dart';
import 'package:midow/screen/detalhes-estabelecimento.dart';
import 'package:midow/screen/favoritos.dart';
import 'package:midow/screen/maps.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _selectedDrawerIndex = 0;

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    super.initState();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MapsPage(drawerKey: _drawerKey);
      case 1:
        return new FavoritosPage(drawerKey: _drawerKey);

      default:
        return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: Drawer(
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
                            Text('Clique para cadastrar-se')
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
                              _onSelectItem(index - 1);
                              _selectedIndex = index;
                              setState(() {});
                            },
                          )));
                }
              }),
        )),
        body: _getDrawerItemWidget(_selectedDrawerIndex));
  }
}
