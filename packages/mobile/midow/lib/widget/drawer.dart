import 'package:midow/screen/favorites.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                            backgroundColor: Theme.of(context).primaryColor),
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
                      color: _selectedIndex != null && _selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      child: ListTile(
                        title: menu[index - 1],
                        onTap: () {
                          if (index - 1 == 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesPage()),
                            );
                          }
                          _selectedIndex = index;
                          setState(() {});
                        },
                      )));
            }
          }),
    ));
  }
}
