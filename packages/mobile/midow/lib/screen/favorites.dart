import 'package:midow/widget/favorite-cart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/bloc/favorites.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class FavoritesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  FavoritesPage({this.drawerKey});
  @override
  State<FavoritesPage> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage>
    with TickerProviderStateMixin {
  final bloc = BlocProvider.getBloc<FavoritesBloc>();

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
                  return FavoriteCardWidget(estabelecimento: snapshot.data[index]);
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
