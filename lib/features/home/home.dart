import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:messenger/auth/login.dart';
import 'package:messenger/features/global_messages.dart';
import 'package:messenger/features/home/applicants_row.dart';
import 'package:messenger/features/home/messages_area.dart';
import 'package:messenger/features/home/send_message_row.dart';
import 'package:messenger/features/settings_page.dart';
import 'package:messenger/main.dart';
import 'package:messenger/features/applicants_page.dart';

class MessagesState {
  List<Message> messages = [];
}

class MessagesSpark extends Spark<MessagesState> {
  late AuthentictaionRepository authentictaionRepository = find();
  @override
  init() => SynchronousFuture(MessagesState());

  void onLoggedOut() async {
    emitAsync(
      () async {
        await authentictaionRepository.logout();
        return state;
      },
    );
    navigator.toRemoveUntil(LoginPage());
  }
}

class MessagesPage extends Feature<MessagesSpark> {
  const MessagesPage({super.key});

  @override
  MessagesSpark createSpark() => MessagesSpark();

  @override
  Widget build(BuildContext context, spark) {
    return FScaffold(
      header: FHeader(
        title: const Text('Messages'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.globe),
            onPress: () {
              // Temporarily removed GlobalMessages navigation
              navigator.to(GlobalMessages());
            },
          ),
          FHeaderAction(
            icon: Icon(FIcons.contactRound),
            onPress: () {
              navigator.to(ApplicantsPage());
            },
          ),
          FHeaderAction(
            icon: Icon(FIcons.settings2),
            onPress: () {
              navigator.to(const SettingsPage());
            },
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        children: [
          ApplicantsRow(),
          Expanded(child: MessagesArea()),
          const SendMessageRow(),
        ],
      ),
    );
  }
}
