import 'package:forui/forui.dart';
import 'package:messenger/auth/login.dart';
import 'package:messenger/main.dart';

class SettingsSpark extends Spark<bool> {
  late AuthentictaionRepository authentictaionRepository = watch();
  @override
  Future<bool> init() async => authentictaionRepository.state.dark;

  void onLoggedOut() {
    authentictaionRepository.logout();
    navigator.toRemoveUntil(LoginPage());
  }

  void onDarkToggled() {
    emitAsync(
      () async {
        await authentictaionRepository.setDark(!state);
        return authentictaionRepository.state.dark;
      },
    );
  }
}

class SettingsPage extends Feature<SettingsSpark> {
  const SettingsPage({super.key});
  @override
  SettingsSpark createSpark() => SettingsSpark();

  @override
  Widget build(context, spark) {
    return FScaffold(
      header: FHeader(
        title: const Text('Settings'),
        suffixes: [
          FHeaderAction.x(onPress: navigator.back),
        ],
      ),
      child: Column(
        spacing: 8,
        children: [
          FButton(
            onPress: spark.onDarkToggled,
            child: Text(
              spark.state ? "DARK" : 'LIGHT',
            ),
          ),
          FButton(
            child: const Text('LOG OUT'),
            onPress: spark.onLoggedOut,
          ),
        ],
      ),
    );
  }
}
