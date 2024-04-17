import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bikers_junction_app/models/message.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/widgets/message_widgets.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';

class EventChat extends StatefulWidget {
  final String eventID;
  static const String routeName = "/eventchat";
  const EventChat({Key? key, required this.eventID}) : super(key: key);

  @override
  State<EventChat> createState() => _EventChatState();
}

class _EventChatState extends State<EventChat> {
  late IO.Socket socket;
  ChatService chatService = ChatService();
  final TextEditingController _message = TextEditingController();
  List<Message>? messages = [];
  late String userID = "";

  @override
  void initState() {
    super.initState();
    getMessageHistory();
    connect();
    userID = Provider.of<UserProvider>(context, listen: false).user.id;
  }

  @override
  void dispose() {
    socket.dispose(); // Dispose the socket connection
    super.dispose();
  }

  void connect() {
    try {
      socket = IO.io(uri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false
      });

      socket.connect();

      // Join event room on connection
      socket.emit('joinEventRoom',
          widget.eventID); // Replace eventId with the actual event ID

      socket.on('connect', (_) {
        print('Connected to server');
      });

      socket.on('serverMsg', (msg) {
        print(msg);
        if (msg['userID'] != userID && mounted) {
          setState(() {
            messages!.add(Message(
                message: msg['msg'],
                senderName: msg['senderName'],
                senderID: msg['userID'],
                time: DateFormat('HH:mm').format(DateTime.now())));
          });
        }
      });
    } catch (e) {
      print('Error connecting to server: $e');
    }
  }

  void sendMsg(String msg, String senderName) {
    Message ownMsg = Message(
        message: msg,
        senderName: senderName,
        senderID: userID,
        time: DateFormat('HH:mm').format(DateTime.now()));
    messages!.add(ownMsg);
    setState(() {
      messages;
    });

    socket.emit('sendMsg', {
      'msg': msg,
      'senderName': senderName,
      'userID': userID,
      'eventId': widget.eventID,
      'time': DateFormat('HH:mm').format(DateTime.now())
    });

    messages!.forEach((message) {
      print(
        'Message: ${message.message}, Sender: ${message.senderName},${message.senderID}',
      );
    });
  }

  getMessageHistory() async {
    messages = await chatService.getchathistory(context, widget.eventID);
    setState(() {
      messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg4.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages!.length,
                itemBuilder: (context, index) {
                  if (messages![index].senderID == user.id) {
                    return OwnMsgWidget(
                      message: messages![index].message,
                      sendername: messages![index].senderName,
                      time: DateFormat('HH:mm').format(DateTime.now()),
                    );
                  } else {
                    return OtherMsgWidget(
                      message: messages![index].message,
                      sendername: messages![index].senderName,
                      time: DateFormat('HH:mm').format(DateTime.now()),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(132, 87, 172, 194),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _message,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Type here..."),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      String msg = _message.text;
                      if (msg.isNotEmpty) {
                        sendMsg(msg, user.fullname);
                        _message.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
