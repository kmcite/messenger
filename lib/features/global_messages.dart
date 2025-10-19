import 'package:forui/forui.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/extensions.dart';

class MessagesSpark extends Spark<Iterable<Message>> {
  late final authenticationRepository = find<AuthentictaionRepository>();
  @override
  Future<Iterable<Message>> init() async {
    applicant = find<AuthentictaionRepository>().applicant;
    return await authenticationRepository.client.messages.getGlobalMessages();
  }

  Future<void> onSendGlobalMessage(Message message) async {
    emitAsync(
      () async {
        await authenticationRepository.client.messages
            .sendGlobalMessage(message);
        return await authenticationRepository.client.messages
            .getGlobalMessages();
      },
    );
    onMessageTextChanged('');
  }

  late Applicant applicant;
  String messageText = '';
  onMessageTextChanged(String messageText) {
    this.messageText = messageText;
    emit(state);
  }

  void onMessageDeleted(Message message) {
    emitAsync(() async {
      await authenticationRepository.client.messages.deleteMessage(message);
      return await authenticationRepository.client.messages.getGlobalMessages();
    });
  }
}

class GlobalMessages extends Feature<MessagesSpark> {
  @override
  MessagesSpark createSpark() => MessagesSpark();

  @override
  Widget build(BuildContext context, spark) {
    return FScaffold(
      header: FHeader(
        title: 'Global'.text(),
        suffixes: [
          FHeaderAction.x(onPress: navigator.back),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: spark.state.length,
              itemBuilder: (BuildContext context, int index) {
                final message = spark.state.elementAt(index);
                return FTile(
                  title: message.message.text(),
                  subtitle: message.time.text(),
                  suffix: FButton.icon(
                    onPress: () => spark.onMessageDeleted(message),
                    child: Icon(FIcons.delete),
                  ),
                );
              },
            ),
          ),
          FTextField(
            initialText: spark.messageText,
            onChange: spark.onMessageTextChanged,
            suffixBuilder: (context, value, child) => FButton.icon(
              style: FButtonStyle.primary(),
              onPress: spark.messageText.isEmpty
                  ? null
                  : () => spark.onSendGlobalMessage(
                        Message(
                          message: spark.messageText,
                          senderId: spark.applicant.id!,
                          time: DateTime.now(),
                        ),
                      ),
              child: Icon(FIcons.send),
            ).pad(),
          ).pad(),
        ],
      ),
    );
  }
}
