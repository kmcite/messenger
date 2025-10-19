import 'package:forui/forui.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/extensions.dart';
import 'package:messenger/utils/messages.dart';

class MessagesAreaSpark extends Spark<Iterable<Message>> {
  late final MessagesRepository messagesRepository = find();

  @override
  Future<Iterable<Message>> init() async {
    messagesRepository.stream.listen(emit);
    return messagesRepository.getMessages();
  }

  void onMessageDeleted(Message message) async {
    emitAsync(
      () async {
        await messagesRepository.client.messages.deleteMessage(message);
        return messagesRepository.getMessages();
      },
    );
  }
}

class MessagesArea extends Feature<MessagesAreaSpark> {
  const MessagesArea({super.key});
  @override
  createSpark() => MessagesAreaSpark();

  @override
  Widget build(BuildContext context, spark) {
    return ListView.builder(
      itemCount: spark().length,
      itemBuilder: (context, i) {
        final message = spark().elementAt(i);
        return FItem(
          title: message.message.text(),
          suffix: FButton.icon(
            style: FButtonStyle.destructive(),
            onPress: () {
              spark.onMessageDeleted(message);
            },
            child: Icon(Icons.remove),
          ),
        );
      },
    );
  }
}
