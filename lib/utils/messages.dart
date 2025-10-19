import 'package:messenger/main.dart';

class MessagesRepository extends AliveRepository<Iterable<Message>> {
  AliveRepository() {
    client.messages.getGlobalMessages().then((messages) => emit(messages));
  }

  late final client = serve<Client>();
  Future<void> sendMessage(Message message, Applicant? toUser) async {
    if (toUser != null)
      await client.messages.sendMessage(message..receiverId = toUser.id);
    else
      await client.messages.sendGlobalMessage(message);

    emitAsync(client.messages.getGlobalMessages);
  }

  Future<void> sendGlobal(Message message) async {
    await client.messages.sendGlobalMessage(message);
    emitAsync(client.messages.getGlobalMessages);
  }

  Future<List<Message>> getMessages() {
    return client.messages.getGlobalMessages();
  }
}
