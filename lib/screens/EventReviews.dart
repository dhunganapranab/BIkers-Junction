import 'package:bikers_junction_app/models/eventRating.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventReviews extends StatefulWidget {
  final String eventID;
  const EventReviews({super.key, required this.eventID});

  @override
  State<EventReviews> createState() => _EventReviewsState();
}

class _EventReviewsState extends State<EventReviews> {
  List<Rating>? ratings;
  final EventService eventService = EventService();

  @override
  void initState() {
    super.initState();
    getEmergency();
  }

  getEmergency() async {
    ratings = await eventService.getEventReviews(context, widget.eventID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double aspRatio = user.role == "Event Creator" ? 2.4 : 2.0;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CustomCard(
            width: screenWidth,
            colors: const [
              Color.fromARGB(184, 82, 44, 23),
              Color.fromARGB(48, 37, 105, 102),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Title1(titleName: "Event Reviews"),
                const SizedBox(height: 10),
                ratings == null || ratings!.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300.0),
                        child: Center(
                            child: Text(
                          "No reviews yet!!",
                          style: TextStyle(color: Colors.white54),
                        )),
                      )
                    : Container(
                        height: screenHeight * 0.72,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: GridView.builder(
                            itemCount: ratings!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: aspRatio),
                            itemBuilder: (context, index) {
                              final reviewData = ratings![index];
                              return CustomCard(
                                width: screenWidth,
                                height: 50,
                                colors: const [
                                  Color.fromARGB(96, 33, 39, 18),
                                  Color.fromARGB(108, 86, 107, 61),
                                ],
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Title1(
                                        titleName: " ${reviewData.userName}",
                                        color:
                                            Color.fromARGB(212, 231, 233, 80),
                                        fontSize: 16,
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                198, 166, 226, 88),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Title1(
                                          titleName: reviewData.reviewMessage,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Title1(
                                        titleName:
                                            " Rated: ★ ${reviewData.rating} ★",
                                        color: const Color.fromARGB(
                                            255, 255, 166, 0),
                                        fontSize: 16,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
