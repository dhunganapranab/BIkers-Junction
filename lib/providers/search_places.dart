import 'package:bikers_junction_app/models/auto_complete_result.dart';
import 'package:flutter/material.dart';

class PlaceResultsProvider extends ChangeNotifier {
  List<AutoCompleteResult> allReturnedResults = [];

  void setResults(allPlaces) {
    allReturnedResults = allPlaces;
    notifyListeners();
  }
}
