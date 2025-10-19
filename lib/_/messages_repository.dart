// import 'package:messenger/objectbox.g.dart';

// import '../chats/chat.dart';
// import '../main.dart';
// import '../users/users_repository.dart';

// final MessagesRepository messagesRepository = MessagesRepository();

// class MessagesRepository extends Repo<Message> {
//   // final _messages = store.box<Message>();
//   // late final put = _messages.put;
//   // late final remove = _messages.remove;
//   // late final removeAll = _messages.removeAll;
//   // late final get = _messages.get;
//   // late final getAll = _messages.getAll;
//   // late final query = _messages.query;
// }

// @Entity()
// class Message {
//   @Id(assignable: true)
//   int id = 0; // Automatically incremented ID
//   String content = '';
//   DateTime timestamp = DateTime.now();

//   // Sender of the message
//   final ToOne<User> sender = ToOne<User>();

//   // Recipient of the message
//   final ToOne<User> receiver = ToOne<User>();

//   // Optional: Link to the chat for context
//   final ToOne<Chat> chat = ToOne<Chat>();
// }
