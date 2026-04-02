import 'package:messenger/auth/auth_state.dart';
import 'package:messenger/settings/settings_state.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/ui.dart';

class SettingsPage extends AppUI {
  const SettingsPage({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: toggleDark,
              child: Text(
                darkSignal() ? "DARK" : 'LIGHT',
              ),
            ),
            ElevatedButton(
              onPressed: logout,
              child: const Text('LOG OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
