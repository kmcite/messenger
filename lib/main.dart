import 'package:messenger/auth/authentication_bloc.dart';
import 'package:messenger/auth/authentication_page.dart';
import 'package:messenger/chats/chats_bloc.dart';
import 'package:messenger/chats/chats_repository.dart';
import 'package:messenger/messages/messages_bloc.dart';
import 'package:messenger/messages/messages_repository.dart';
import 'package:messenger/navigator.dart';
import 'package:messenger/users/users_bloc.dart';
import 'package:messenger/users/users_repository.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'objectbox.g.dart';

export 'dart:async';
export 'dart:core';
export 'package:flex_color_scheme/flex_color_scheme.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:manager/manager.dart';
export 'package:messenger/chats/chats_page.dart';
export 'package:messenger/settings/settings_page.dart';
export 'package:messenger/settings/theme_mode.dart';
export 'package:states_rebuilder/states_rebuilder.dart';
export 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RM.storageInitializer(HiveStorage());
  final appInfo = await PackageInfo.fromPlatform();
  store = await openStore(
    directory: join(
      (await getApplicationDocumentsDirectory()).path,
      appInfo.appName,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        // Repositories
        Provider(create: (_) => UsersRepository()),
        Provider(create: (_) => MessagesRepository()),
        Provider(create: (_) => NavigationRepository()),
        Provider(create: (_) => AuthenticationRepository()),
        Provider(create: (_) => ChatsRepository()),

        // Notifiers
        ChangeNotifierProvider(create: NavigationController.new),
        ChangeNotifierProvider(create: AuthenticationBloc.new),
        ChangeNotifierProvider(create: (context) => UsersController(context)),
        ChangeNotifierProvider(create: ChatsBloc.new),
        ChangeNotifierProvider(create: MessagesBloc.new),
        ChangeNotifierProvider(create: ThemeModeController.new),
      ],
      child: App(),
    ),
  );
}

late Store store;

class App extends UI {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: context.of<NavigationController>().key,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (_) {
        return MaterialPageRoute(
          builder: (context) {
            return context.of<AuthenticationBloc>().isAuthenticated
                ? ChatsPage()
                : AuthenticationPage();
          },
        );
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: context.of<ThemeModeController>().themeMode,
    );
  }
}
