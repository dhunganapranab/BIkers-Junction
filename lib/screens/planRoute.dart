import 'dart:async';
import 'dart:math';
import 'package:bikers_junction_app/providers/event_provider.dart';
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

class PlanRoute extends StatefulWidget {
  static const String routeName = "/planRoute";
  const PlanRoute({super.key});

  @override
  State<PlanRoute> createState() => _PlanRouteState();
}

class _PlanRouteState extends State<PlanRoute> {
  final _formKey = GlobalKey<FormState>();
  final EventService eventService = EventService();
  final TextEditingController routeName = TextEditingController();
  final TextEditingController startpoint = TextEditingController();
  final TextEditingController destination = TextEditingController();
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Polyline> _polylines = Set<Polyline>();
  int polylineIdCounter = 1;

//defining coordinates for map
  double lat1 = 0.0, long1 = 0.0, lat2 = 0.0, long2 = 0.0;
  LatLng initialLocation = const LatLng(0.0, 0.0);
  LatLng sourcelocation = const LatLng(0.0, 0.0);
  LatLng destinationLocation = const LatLng(0.0, 0.0);

  String org = "";
  String dst = "";

  void _initializeLocation() {
    setState(() {
      sourcelocation = LatLng(lat1, long1);
      org = "$lat1,$long1";
      dst = "$lat2,$long2";
      destinationLocation = LatLng(lat2, long2);
    });
  }

  void createRoute(String eventID) {
    eventService.createRoute(
        context: context,
        routeName: routeName.text,
        startPointCoordinates: org,
        destinationPointCoordinates: dst,
        eventID: eventID);
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

  gotoPlace(
    double lat,
    double lng,
    double endLat,
    double endLng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
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
  Widget build(BuildContext context) {
    MapServices mapServices = MapServices();
    final event = Provider.of<EventProvider>(context).event;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 50, 54, 26),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            buttonText: "logout",
            onPressed: () {},
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Label1(labelName: "Plan Your Riding Route"),
          ),
          SizedBox(
            height: screenHeight * 0.55,
            width: screenWidth,
            child: GoogleMap(
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
                        mapController!
                            .showMarkerInfoWindow(const MarkerId('marker1'));
                      }),
                ),
                Marker(
                    markerId: const MarkerId("marker2"),
                    position: destinationLocation,
                    infoWindow: InfoWindow(
                        title: "DestinationPoint: $dst",
                        onTap: () {
                          mapController!
                              .showMarkerInfoWindow(const MarkerId('marker2'));
                        }))
              },
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
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                        child: Text(
                          "Note: Please enter latitude and longitude of the location for start and destination.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 197, 224, 150),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomTextField(
                          width: screenWidth * 0.9,
                          height: 40,
                          controller: startpoint,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                          hintText: "Enter co-ordinates of start point",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomTextField(
                          width: screenWidth * 0.9,
                          height: 40,
                          controller: destination,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                          hintText: "Enter co-ordinates of Destination point",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomTextField(
                          width: screenWidth * 0.9,
                          height: 40,
                          controller: routeName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                          hintText: "Enter routename eg.Kathmandu to Pokhara.",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomButton(
                            color: const Color.fromARGB(255, 189, 121, 20),
                            width: screenWidth * 0.3,
                            height: 35,
                            onPressed: () async {
                              setState(() {
                                lat1 = double.parse(
                                    startpoint.text.split(",")[0].trim());
                                long1 = double.parse(
                                    startpoint.text.split(",")[1].trim());
                                lat2 = double.parse(
                                    destination.text.split(",")[0].trim());
                                long2 = double.parse(
                                    destination.text.split(",")[1].trim());
                                initialLocation = LatLng(lat1, long1);
                              });
                              _initializeLocation();
                              _updateCameraPosition(sourcelocation);
                              var directions =
                                  await mapServices.getDirections(org, dst);
                              gotoPlace(
                                  directions['start_location']['lat'],
                                  directions['start_location']['lng'],
                                  directions['end_location']['lat'],
                                  directions['end_location']['lng'],
                                  directions['bounds_ne'],
                                  directions['bounds_sw']);
                              _setPolyline(directions['polyline_decoded']);
                              showAreaBetweenMarkers();
                            },
                            buttonText: const Text(
                              "Save route",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ),
                      CustomButton(
                          color: const Color.fromARGB(255, 116, 189, 20),
                          width: screenWidth * 0.7,
                          height: 40,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createRoute(event.id as String);
                            }
                          },
                          buttonText: const Text(
                            "Confirm Destination",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ],
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
