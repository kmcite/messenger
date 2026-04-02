import 'package:forui/forui.dart';
import 'package:messenger/navigation/navigator_key.dart';
import 'package:messenger/messages/global_messages.dart';
import 'package:messenger/messages/applicants_row.dart';
import 'package:messenger/messages/messages_area.dart';
import 'package:messenger/messages/send_message_row.dart';
import 'package:messenger/settings/settings_page.dart';
import 'package:messenger/main.dart';
import 'package:messenger/applicants/applicants_page.dart';
import 'package:messenger/utils/ui.dart';

class MessagesPage extends AppUI {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(FIcons.globe),
            onPressed: () {
              navigateTo(GlobalMessages());
            },
          ),
          IconButton(
            icon: Icon(FIcons.contactRound),
            onPressed: () {
              navigateTo(ApplicantsPage());
            },
          ),
          IconButton(
            icon: Icon(FIcons.settings2),
            onPressed: () {
              navigateTo(const SettingsPage());
            },
          ),
        ],
      ),
      body: Column(
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
