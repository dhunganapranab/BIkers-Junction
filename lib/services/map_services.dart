import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/models/auto_complete_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MapServices {
  final String key = "AIzaSyBWY43XU_ON4tp5isGL3DGIP5MUZh0V01U";
  final String types = "geocode";

  Future<List<AutoCompleteResult>> searchPlaces(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['predictions'] as List;

    return results.map((e) => AutoCompleteResult.fromJson(e)).toList();
  }

  Future<void> getDirections(String origin, String destination) async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&key=$googleApiKey";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    print(json);
  }
}
