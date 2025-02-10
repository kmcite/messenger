import 'package:messenger/chats/chat.dart';
import 'package:messenger/main.dart';

class ChatsRepository {
  final _chats = store.box<Chat>();
  late final put = _chats.put;
  late final get = _chats.get;
  late final remove = _chats.remove;
  late final getAll = _chats.getAll;
  late final query = _chats.query;
}
