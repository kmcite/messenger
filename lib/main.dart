import 'package:messenger/utils/messages.dart';

import 'main.dart';
import 'package:messenger/messenger.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:flutter/material.dart';
export 'package:manager_client/manager_client.dart'
    hide Application, VoidCallback;
export 'package:spark/spark.dart';

export 'package:messenger/utils/authentication.dart';
export 'dart:async';
export 'dart:core';
export 'package:uuid/uuid.dart';

void main() => runApp(MessengerApp());

const localhost = '127.0.0.1';

class MessengerApp extends Application {
  @override
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
    final serverUrl =
        serverUrlFromEnv.isEmpty ? 'http://$localhost:8080/' : serverUrlFromEnv;
    final client = Client(serverUrl);
    putService(prefs);
    putService(client);
    putRepository(AuthentictaionRepository());
    putRepository(MessagesRepository());
  }

  @override
  Widget buildApp(BuildContext context) => MessengerView();
}
