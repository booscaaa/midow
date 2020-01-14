import 'package:midow/model/establishment.dart';
import 'package:flutter/material.dart';

class FavoriteCardWidget extends StatelessWidget {
  final Establishment estabelecimento;

  FavoriteCardWidget({this.estabelecimento});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Card(
          child: Center(
            child: Text(estabelecimento.name.toUpperCase()),
          ),
        ));
  }
}
