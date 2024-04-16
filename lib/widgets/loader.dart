import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 450,
        constraints: BoxConstraints(maxHeight: height * 0.68),
        decoration: BoxDecoration(
            color: const Color.fromARGB(124, 71, 71, 71),
            borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.only(top: 300.0),
          child: SizedBox(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Text(
                  "Getting Events...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Loader1 extends StatelessWidget {
  const Loader1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Center(
          child: SizedBox(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Text(
                  "Fetching Current Location",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
