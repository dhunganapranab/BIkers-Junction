import 'dart:convert';

class RouteDetails {
  final String routeName;
  final String startPointCoordinates;
  final String destinationPointCoordinates;

  RouteDetails(
      {required this.routeName,
      required this.startPointCoordinates,
      required this.destinationPointCoordinates});

  Map<String, dynamic> toMap() {
    return {
      'routeName': routeName,
      'startPointCoordinates': startPointCoordinates,
      'destinationPointCoordinates': destinationPointCoordinates,
    };
  }

  factory RouteDetails.fromMap(Map<String, dynamic> map) {
    return RouteDetails(
      routeName: map['routeName'] ?? '',
      startPointCoordinates: map['startPointCoordinates'] ?? '',
      destinationPointCoordinates: map['destinationPointCoordinates'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteDetails.fromJson(String source) =>
      RouteDetails.fromMap(json.decode(source));
}
