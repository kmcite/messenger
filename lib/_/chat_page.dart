// import 'package:messenger/main.dart';

// class ChatPage extends StatefulWidget {
//   final dynamic chat;

//   const ChatPage({super.key, required this.chat});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     void sendMessage() {
//       if (messageController.text.isNotEmpty) {
//         setState(
//           () {
//             // context.of<ChatsBloc>().put(
//             //       widget.chat
//             //         ..messages.add(
//             //           Message()
//             //             ..content = messageController.text
//             //             ..sender.target = widget.chat.sender.target
//             //             ..receiver.target = widget.chat.user.target,
//             //         ),
//             //     );
//           },
//         );
//         messageController.clear();
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.chat.name),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // context.of<NavigationController>().back();
//               // context.of<ChatsBloc>()..remove(widget.chat.id);
//             },
//             icon: Icon(Icons.delete),
//           ).pad(),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.chat.messages.length,
//               itemBuilder: (context, index) {
//                 final message = widget.chat.messages[index];
//                 return ListTile(
//                   title: message.content.text(),
//                   subtitle: Column(
//                     children: [
//                       message.sender.target.text(),
//                       message.receiver.target.text(),
//                     ],
//                   ),
//                 ).card();
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: messageController,
//                   decoration: const InputDecoration(
//                     hintText: 'Type a message',
//                   ),
//                   onSubmitted: (value) {
//                     if (value.isNotEmpty) {
//                       setState(
//                         () {
//                           // context.of<ChatsBloc>().put(
//                           //       widget.chat
//                           //         ..messages.add(
//                           //           Message()
//                           //             ..content = value
//                           //             ..sender.target =
//                           //                 widget.chat.sender.target
//                           //             ..receiver.target =
//                           //                 widget.chat.user.target,
//                           //         ),
//                           //     );
//                         },
//                       );
//                       messageController.clear();
//                     }
//                   },
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: () {
//                   sendMessage();
//                 },
//               ),
//             ],
//           ).pad(),
//         ],
//       ),
//     );
//   }
// }
