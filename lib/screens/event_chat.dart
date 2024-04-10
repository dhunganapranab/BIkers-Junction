import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/models/message.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/widgets/message_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class EventChat extends StatefulWidget {
  static const String routeName = "/eventchat";
  const EventChat({super.key});

  @override
  State<EventChat> createState() => _EventChatState();
}

class _EventChatState extends State<EventChat> {
  // final SocketService socket = SocketService();
  final TextEditingController _message = TextEditingController();
  List<Message> messages = [];
  late String userID;

  IO.Socket? socket;
  void connect() {
    try {
      socket = IO.io(uri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket!.connect();
      socket!.onConnect((_) {
        print("connected into frontend");

        socket!.on("serverMsg", (msg) {
          print(msg);
          if (msg["userID"] != userID) {
            Message(
              msg: msg['msg'],
              type: msg['type'],
              sender: msg['senderName'],
            );
          }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void sendMsg(String msg, String senderName) {
    Message ownMsg = Message(msg: msg, type: "ownMsg", sender: senderName);
    messages.add(ownMsg);
    setState(() {
      messages;
    });
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "senderName": senderName,
      "userID": userID
    });
  }

  @override
  void initState() {
    super.initState();
    userID = Provider.of<UserProvider>(context, listen: false).user.id;
    connect();
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
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              buttonText: "logout",
              onPressed: () {
                Navigator.pushNamed(context, 'logout');
              },
            )),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      if (messages[index].type == "ownMsg") {
                        return OwnMsgWidget(
                            message: messages[index].msg,
                            sendername: messages[index].sender,
                            time: DateFormat('HH:mm').format(DateTime.now()));
                      } else {
                        return OtherMsgWidget(
                            message: messages[index].msg,
                            sendername: messages[index].sender,
                            time: DateFormat('HH:mm').format(DateTime.now()));
                      }
                    })),
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
                  )),
                  IconButton(
                    onPressed: () {
                      String msg = _message.text;
                      if (msg.isNotEmpty) {
                        sendMsg(_message.text, user.fullname);
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
