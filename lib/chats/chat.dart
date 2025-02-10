import 'package:messenger/main.dart';

import '../messages/messages_repository.dart';
import '../users/users_repository.dart';

@Entity()
class Chat {
  @Id(assignable: true)
  int id = 0; // Automatically incremented ID
  final user = ToOne<User>();
  final sender = ToOne<User>();
  String get name => user.target?.name ?? '';
  // Messages in the chat
  @Backlink('chat')
  final ToMany<Message> messages = ToMany<Message>();
}
