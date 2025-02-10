import 'package:messenger/auth/authentication_bloc.dart';
import 'package:messenger/main.dart';
import 'package:messenger/navigator.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              context.of<NavigationController>().to(ChatsPage());
            },
            icon: Icon(Icons.home),
          ).pad(),
        ],
      ),
      body: Column(
        children: [
          DropdownButtonFormField<ThemeMode>(
            value: context.of<ThemeModeController>().themeMode,
            onChanged: context.of<ThemeModeController>().specificThemeMode,
            items: ThemeMode.values.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: value.name.text(),
                );
              },
            ).toList(),
          ).pad(),
          context.of<AuthenticationBloc>().user.text(),
          FilledButton(
            onPressed: () {
              context.of<AuthenticationBloc>().logout();
            },
            child: 'logout'.text(),
          ).pad(),
          FilledButton(
            onPressed: () {
              context.of<AuthenticationBloc>().delete();
            },
            child: 'delete account'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
