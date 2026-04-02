import 'package:messenger/auth/login.dart';
import 'package:messenger/messages/home.dart';
import 'package:signals/signals.dart';

import '../navigation/navigator_key.dart';

final nameSignal = signal('');
final emailSignal = signal('');
final passwordSignal = signal('');
final authenticatedSignal = signal(false);

void login() {
  authenticatedSignal.set(true);
}

void register() {
  authenticatedSignal.set(true);
}

void logout() {
  authenticatedSignal.set(false);
}

Effect? authenticationEffect = Effect(
  () {
    if (authenticatedSignal()) {
      navigateUntil(MessagesPage());
    } else {
      navigateUntil(LoginPage());
    }
    print('Authentication <-> Navigation');
  },
);
