import 'package:messenger/auth/authentication_bloc.dart';
import 'package:messenger/main.dart';
import 'package:messenger/objectbox.g.dart';
import 'package:messenger/users/users_repository.dart';

import 'chat.dart';
import 'chats_repository.dart';

class ChatsBloc extends ChangeNotifier {
  final ChatsRepository chatsRepository;
  final AuthenticationRepository authenticationRepository;
  List<Chat> _chats = [];
  ChatsBloc(BuildContext context)
      : chatsRepository = context.of(),
        authenticationRepository = context.of() {
    refresh(authenticationRepository.user);
  }
  List<Chat> get chats => _chats;

  void put(Chat chat) => chatsRepository.put(
        chat..sender.target = authenticationRepository.user,
      );

  void remove(int id) {
    chatsRepository.remove(id);
  }

  void refresh(User? user) {
    if (user != null) {
      _chats = chatsRepository
          .query(
            Chat_.user.equals(user.id),
          )
          .build()
          .find();
    }
    notifyListeners();
  }
}
