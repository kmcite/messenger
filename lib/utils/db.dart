import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

final hiveSignal = signal<Box?>(null, debugLabel: 'hive');
final preferencesSignal =
    signal<SharedPreferences?>(null, debugLabel: 'preferences');

Future<void> initialize() async {
  await Hive.initFlutter();
  hiveSignal.value = await Hive.openBox('messages');
  preferencesSignal.value = await SharedPreferences.getInstance();
}
