import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:midow/bloc/favorito.dart';
import 'package:midow/widget/drawer.dart';

class FavoritosPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  FavoritosPage({this.drawerKey});
  @override
  State<FavoritosPage> createState() => FavoritosPageState();
}

class FavoritosPageState extends State<FavoritosPage>
    with TickerProviderStateMixin {
  final bloc = BlocProvider.getBloc<FavoritoBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
              heroTag: null,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.menu),
              onPressed: () {
                widget.drawerKey.currentState.openDrawer();
              },
            )),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: bloc.estabelecimentos,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Text(snapshot.data[index].nome);
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
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
