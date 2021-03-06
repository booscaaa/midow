import 'package:background_fetch/background_fetch.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/bloc/favorites.dart';
import 'package:midow/screen/home.dart';
import 'package:flutter/material.dart';
import 'bloc/establishment.dart';

void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const Color PRIMARY = Color(0xFFA587E8);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => EstablishmentBloc()),
        Bloc((i) => FavoritesBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  textTheme: TextTheme(
                      title: TextStyle(
                          color: PRIMARY,
                          fontWeight: FontWeight.bold,
                          fontSize: 17))),
              primarySwatch: Colors.blue,
              primaryColor: PRIMARY),
          home: HomePage()),
    );
  }
}
