import 'package:forui/forui.dart';
import 'package:messenger/messages/messages_state.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/extensions.dart';
import 'package:messenger/utils/ui.dart';

class MessagesArea extends AppUI {
  const MessagesArea({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messagesSignal.length,
      itemBuilder: (context, i) {
        final message = messagesSignal.elementAt(i);
        return FItem(
          title: message.message.text(),
          suffix: FButton.icon(
            onPress: () {
              // spark.onMessageDeleted(message);
            },
            child: Icon(Icons.remove),
          ),
        );
      },
    );
  }
}
