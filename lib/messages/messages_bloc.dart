import 'package:messenger/main.dart';
import 'package:messenger/messages/messages_repository.dart';

class MessagesBloc extends ChangeNotifier {
  final MessagesRepository _messagesRepository;
  MessagesBloc(BuildContext context) : _messagesRepository = context.of() {
    refresh();
  }
  List<Message> _messages = [];
  List<Message> get messages => _messages;
  void put(Message message) {
    _messagesRepository.put(message);
    refresh();
  }

  void remove(int id) {
    _messagesRepository.remove(id);
    refresh();
  }

  void refresh() {
    _messages = _messagesRepository.getAll();
    notifyListeners();
  }
}
