import 'package:messenger/auth/auth_state.dart';
import 'package:messenger/utils/db.dart';
import 'package:messenger/utils/ui.dart';

import 'main.dart';

export 'package:flutter/material.dart';

export 'dart:async';
export 'dart:core';
export 'package:uuid/uuid.dart';
import 'package:forui/forui.dart';
import 'package:messenger/auth/login.dart';
import 'package:messenger/settings/settings_state.dart';
import 'package:messenger/navigation/navigator_key.dart';
import 'package:messenger/messages/home.dart';

void main() => runApp(MessengerApplication());

class MessengerApplication extends AppUI {
  const MessengerApplication({super.key});
  @override
  void init(BuildContext context) {
    initialize();
    authenticationEffect!();
  }

  @override
  void dispose() {
    authenticationEffect?.dispose();
    authenticationEffect = null;
  }

  @override
  Widget build(context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: false).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: false).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      builder: (context, child) => FTheme(
        data: FThemeData(
          colors: darkSignal()
              ? FThemes.yellow.dark.colors
              : FThemes.green.light.colors,
          typography: FTypography(defaultFontFamily: 'Monaspace Argon'),
        ),
        child: child!,
      ),
      themeMode: darkSignal() ? ThemeMode.dark : ThemeMode.light,
      home: authenticatedSignal() ? MessagesPage() : LoginPage(),
    );
  }
}
