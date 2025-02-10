import 'package:messenger/main.dart';
import 'package:messenger/objectbox.g.dart';

import '../chats/chat.dart';

class UsersRepository {
  final _users = store.box<User>();
  late final get = _users.get;
  late final query = _users.query;
  late final put = _users.put;
  late final remove = _users.remove;
  late final removeAll = _users.removeAll;
  late final getAllAsync = _users.getAllAsync;
  late final getAll = _users.getAll;

  bool isUserEmailPresent(String email) {
    try {
      final user = _users.query(User_.email.equals(email)).build().find().first;
      return _users.contains(user.id);
    } catch (e) {}
    return false;
  }

  User userByEmail(String email) =>
      getAll().where((user) => user.email == email).first;
}

@Entity()
class User {
  @Id()
  int id = 0;
  String email = '';
  String name = '';
  String password = '';
  @Backlink('user')
  final chats = ToMany<Chat>();
  @override
  String toString() {
    return 'User{id: $id, email: $email, name: $name, password: $password}';
  }
}
