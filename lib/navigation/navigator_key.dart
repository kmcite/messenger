import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<T?> navigateTo<T extends Object?>(Widget page) async {
  return await navigatorKey.currentState?.push<T>(
    MaterialPageRoute(builder: (context) => page),
  );
}

void navigateBack<T>([T? result]) {
  return navigatorKey.currentState?.pop(result);
}

Future<T?> toDialog<T>(Widget dialog) async {
  return await showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => dialog,
  );
}

Future<T?> navigateUntil<T extends Object?>(Widget page) async {
  return await navigatorKey.currentState?.pushAndRemoveUntil<T>(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}
