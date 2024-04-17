import 'dart:async';
import 'dart:math';

import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/providers/route_provider.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/map_services.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteDetailScreen extends StatefulWidget {
  final String startpoint;
  final String destination;
  const RouteDetailScreen(
      {super.key, required this.startpoint, required this.destination});

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final MapServices mapServices = MapServices();
  final EventService eventService = EventService();
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();
  String source = "";

  final Set<Polyline> _polylines = Set<Polyline>();
  int polylineIdCounter = 1;

//defining coordinates for map
  double lat1 = 0.0, lat2 = 0.0, lat3 = 0.0, lat4 = 0.0;
  LatLng initialLocation = const LatLng(0.0, 0.0);
  LatLng sourcelocation = const LatLng(0.0, 0.0);
  LatLng destinationLocation = const LatLng(0.0, 0.0);

  String org = "";
  String dst = "";

  void _initializeLocation() {
    setState(() {
      sourcelocation = LatLng(lat1, lat2);
      org = "$lat1,$lat2";
      dst = "$lat3,$lat4";
      destinationLocation = LatLng(lat3, lat4);
    });
  }

//changing map camera
  void _updateCameraPosition(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 14.5,
        ),
      ),
    );
  }

//function for showing area between two markers
  void showAreaBetweenMarkers() {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
          min(sourcelocation.latitude, destinationLocation.latitude),
          min(sourcelocation.longitude, destinationLocation.longitude)),
      northeast: LatLng(
          max(sourcelocation.latitude, destinationLocation.latitude),
          max(sourcelocation.longitude, destinationLocation.longitude)),
    );

    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50), // Padding of 100 pixels
    );
  }

  gotoPlace(double lat, double lng, double endLat, double endLng,
      Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$polylineIdCounter';

    polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 10,
        color: Colors.blue,
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    lat1 = double.parse(widget.startpoint.split(",")[0].trim());
    lat2 = double.parse(widget.startpoint.split(",")[1].trim());
    lat3 = double.parse(widget.destination.split(",")[0].trim());
    lat4 = double.parse(widget.destination.split(",")[1].trim());
    initialLocation = LatLng(lat1, lat2);
    _initializeLocation();
    _updateCameraPosition(sourcelocation);
    // _fetchRouteDetails();
  }

  // void _fetchRouteDetails() async {
  //   var directions = await mapServices.getDirections(org, dst);
  //   gotoPlace(
  //     directions['start_location']['lat'],
  //     directions['start_location']['lng'],
  //     directions['end_location']['lat'],
  //     directions['end_location']['lng'],
  //     directions['bounds_ne'],
  //     directions['bounds_sw'],
  //   );
  //   _setPolyline(directions['polyline_decoded']);
  //   showAreaBetweenMarkers();
  // }

  @override
  Widget build(BuildContext context) {
    final route = Provider.of<RouteDetailProvider>(context).route;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 50, 54, 26),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar()),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Label1(labelName: "Route Details"),
          ),
          SizedBox(
            height: screenHeight * 0.55,
            width: screenWidth,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: initialLocation.latitude == 0.0 &&
                              initialLocation.longitude == 0.0
                          ? const LatLng(27.700769,
                              85.300140) // Default coordinates if sourcelocation is (0.0, 0.0)
                          : initialLocation,
                      zoom: 14.5),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  polylines: _polylines,
                  markers: {
                    Marker(
                      markerId: const MarkerId("marker1"),
                      position: sourcelocation,
                      infoWindow: InfoWindow(
                          title: "StartPoint: $org",
                          onTap: () {
                            mapController!.showMarkerInfoWindow(
                                const MarkerId('marker1'));
                          }),
                    ),
                    Marker(
                        markerId: const MarkerId("marker2"),
                        position: destinationLocation,
                        infoWindow: InfoWindow(
                            title: "DestinationPoint: $dst",
                            onTap: () {
                              mapController!.showMarkerInfoWindow(
                                  const MarkerId('marker2'));
                            }))
                  },
                ),
                Positioned(
                  bottom: 10, // Adjust this value to set the bottom margin
                  left: 10, // Adjust this value to set the right margin
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(230, 61, 245, 70),
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          'google.navigation:q=$lat1,$lat2&key=$googleApiKey'));
                    },
                    child: const Icon(
                      Icons.navigation_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(153, 163, 223, 220),
                    Color.fromARGB(118, 26, 36, 29)
                  ],
                ),
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 1.0,
                )),
            child: Scrollbar(
              radius: const Radius.circular(10.0),
              thickness: 4.0,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: screenHeight * 0.284,
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(144, 93, 126, 74),
                              Color.fromARGB(255, 142, 165, 155)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 1.5, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Here are the route details:",
                            style: TextStyle(
                                color: Color.fromARGB(255, 203, 248, 0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Route Name: ${route.routeName}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 166, 255, 22),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "StartPointCoordinates:\n${route.startPointCoordinates}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 41, 255, 12),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "DestinationPointCoordinates:\n${route.destinationPointCoordinates}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 193, 21),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomButton(
                                color: const Color.fromARGB(160, 224, 25, 25),
                                width: screenWidth * 0.4,
                                height: 35,
                                onPressed: () {},
                                buttonText: const Text(
                                  "Back",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
