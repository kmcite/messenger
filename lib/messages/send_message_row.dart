import 'package:messenger/main.dart';
import 'package:messenger/utils/extensions.dart';
// import 'package:messenger/utils/messages.dart';
import 'package:messenger/utils/ui.dart';

// class SendMessageSpark extends Spark<String> {
//   late final MessagesRepository messagesRepository = find();
//   late final AuthentictaionRepository authentictaionRepository = find();

//   @override
//   Future<String> init() async {
//     return '';
//   }

//   void onMessageTextChanged(String messageText) {
//     emit(messageText);
//   }

//   void onMessageSent() {
//     messagesRepository.sendGlobal(
//       Message(
//         message: state,
//         senderId: authentictaionRepository.applicant.id!,
//         time: DateTime.now(),
//       ),
//     );
//     emit('');
//   }
// }

class SendMessageRow extends AppUI {
  const SendMessageRow({super.key});

  // @override
  // SendMessageSpark createSpark() => SendMessageSpark();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: spark.state,
      decoration: InputDecoration(),
      // hint: 'Write a message...',
      // onChange: spark.onMessageTextChanged,
      // suffixBuilder: (context, value, child) {
      //   return FButton.icon(
      //     style: FButtonStyle.primary(),
      //     onPress: () => spark.onMessageSent(),
      //     child: Icon(FIcons.arrowBigUp),
      //   );
      // },
    ).pad();
  }
}
