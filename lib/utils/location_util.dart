import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyAlZfoFXOV819B8LnqHVEIqbjgabrvw5sA';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    // String url =
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    Uri url = Uri.https('maps.googleapis.com', 'maps/api/geocode/json', {
      'latlng': '${position.latitude},${position.longitude}',
      'key': GOOGLE_API_KEY,
    });
    print(url.toString());
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
