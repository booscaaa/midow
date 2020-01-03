import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart' as m;
import 'package:google_maps_webservice/directions.dart';
import 'package:location/location.dart' as l;
import 'package:midow/model/estabelecimento.dart';

class DirectionsAPI {
  Future<DirectionsResponse> getRoute(l.LocationData currentPosition, Estabelecimento e) async {
    final directions = GoogleMapsDirections(
        apiKey:
            'AIzaSyCzGKtGFkSMGaiGpw7bFWvRWIwOM1vDgv0');
    DirectionsResponse res = await directions.directionsWithLocation(
        Location(currentPosition.latitude, currentPosition.longitude),
        Location(e.latitude, e.longitude));
    print(res.status);
    if (res.isOkay) {
      print('${res.routes.length} routes');
      for (var r in res.routes) {
        print(r.summary);
      }
    } else {
      print(res.errorMessage);
    }

    directions.dispose();

    return res;
  }
}
