import 'dart:async';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/providers/emergency_provider.dart';
import 'package:bikers_junction_app/services/map_services.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyDetailsScreen extends StatefulWidget {
  static const String routeName = "/emergencyScreen";
  const EmergencyDetailsScreen({super.key});

  @override
  State<EmergencyDetailsScreen> createState() => _EmergencyDetailsScreenState();
}

class _EmergencyDetailsScreenState extends State<EmergencyDetailsScreen> {
  GoogleMapController? mapController;
  MapServices mapservices = MapServices();
  String location = "";
  double lat = 0.0, long = 0.0;

  LatLng sourcelocation = const LatLng(0.0, 0.0);

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

  @override
  void initState() {
    super.initState();
    location = Provider.of<EmergencyProvider>(context, listen: false)
        .emergency
        .userLocation;
    setState(() {
      lat = double.parse(location.split(",")[0].trim());
      long = double.parse(location.split(",")[1].trim());
      sourcelocation = LatLng(lat, long);
      _updateCameraPosition(sourcelocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    final emergency = Provider.of<EmergencyProvider>(context).emergency;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomCard(
                    padding: 4,
                    width: screenWidth,
                    height: screenHeight * 0.87,
                    colors: const [
                      Color.fromARGB(100, 84, 183, 255),
                      Color.fromARGB(50, 2, 2, 2),
                    ],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Title1(
                            titleName: "Emergency Details",
                            color: Color.fromARGB(255, 255, 123, 0),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                          height: screenHeight * 0.55,
                          width: screenWidth,
                          child: Stack(children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: sourcelocation,
                                zoom: 14.5,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                mapController = controller;
                              },
                              markers: {
                                Marker(
                                  position: sourcelocation,
                                  markerId: const MarkerId("marker1"),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                                  infoWindow: const InfoWindow(
                                    title:
                                        "Emergency initiated on this location",
                                  ),
                                ),
                              },
                            ),
                            Positioned(
                              bottom:
                                  10, // Adjust this value to set the bottom margin
                              left:
                                  10, // Adjust this value to set the right margin
                              child: FloatingActionButton(
                                backgroundColor:
                                    Color.fromARGB(230, 61, 245, 70),
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      'google.navigation:q=$lat,$long&key=$googleApiKey'));
                                },
                                child: const Icon(
                                  Icons.navigation_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                              width: screenWidth,
                              height: screenHeight * 0.234,
                              child: Card(
                                color: const Color.fromARGB(164, 47, 218, 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Title1(
                                        titleName:
                                            "Emergency initiated in  this location: ${emergency.userLocation}",
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Title1(
                                        titleName:
                                            "Messsage: ${emergency.message} ",
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Title1(
                                        titleName:
                                            "Initiated by: ${emergency.userName}",
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Title1(
                                        titleName:
                                            "Initiator ID: ${emergency.userID.substring(0, 7)}",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
