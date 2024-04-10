import 'package:flutter/material.dart';

class OwnMsgWidget extends StatelessWidget {
  final String message;
  final String sendername;
  final String time;
  const OwnMsgWidget(
      {super.key,
      required this.message,
      required this.sendername,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 150,
          minWidth: 90,
        ),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sendername,
                    style: const TextStyle(
                        color: Color.fromARGB(181, 0, 132, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 124, 17), fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Color.fromARGB(167, 66, 64, 64),
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class OtherMsgWidget extends StatelessWidget {
  final String message;
  final String sendername;
  final String time;
  const OtherMsgWidget(
      {super.key,
      required this.message,
      required this.sendername,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 150,
          minWidth: 90,
        ),
        child: Card(
            color: Color.fromARGB(255, 156, 243, 255),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sendername,
                    style: const TextStyle(
                        color: Color.fromARGB(181, 0, 132, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 46, 100, 87), fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Color.fromARGB(167, 66, 64, 64),
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
