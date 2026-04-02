import 'package:messenger/messages/messages_state.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/extensions.dart';
import 'package:messenger/utils/ui.dart';
import 'package:signals/signals.dart';

class GlobalMessages extends AppUI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Broadcast'.text(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: globalMessagesSignal.length,
              itemBuilder: (BuildContext context, int index) {
                final message = globalMessagesSignal.elementAt(index);
                return ListTile(
                  title: message.message.text(),
                  subtitle: message.time.text(),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // spark.onMessageDeleted(message);
                    },
                  ),
                );
              },
            ),
          ),
          TextFormField(
            initialValue: messageTextSignal(),
            onChanged: messageTextSignal.set,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: messageTextSignal.value.isEmpty
                    ? null
                    : () => sengMessageGlobally(),
              ),
            ),
          ).pad(),
        ],
      ),
    );
  }
}

final messageTextSignal = signal('');

void sengMessageGlobally() {
  messageTextSignal.set('');
}
