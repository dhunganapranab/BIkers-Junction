// import 'package:bikers_junction_app/constants/global_variables.dart';
// import 'package:bikers_junction_app/models/message.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   IO.Socket? socket;
//   void connect() {
//     socket = IO.io(uri, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket!.connect();
//     socket!.onConnect((_) {
//       print("connected into frontend");
//       socket!.on("ServerMsg", (msg) {
//         print(msg);
//         msgs!.add(msg);
//       });
//     });
//   }

//   void sendMsg(List<Message> msgs, String msg, String senderName) {
//     Message ownMsg = Message(msg: msg, type: "ownMsg", sender: senderName);
//     msgs.add(ownMsg);
//     socket!.emit(
//         'sendMsg', {"type": "ownMsg", "msg": msg, "senderName": senderName});
//   }
// }
