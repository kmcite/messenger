import 'package:forui/forui.dart';
import 'package:messenger/auth/login.dart';
import 'package:messenger/features/home/home.dart';
import 'package:messenger/main.dart';

class ApplicationState {
  bool dark = false;
  bool isAuthenticated = false;
}

class ApplicationSpark extends Spark<ApplicationState> {
  late final authenticationRepository = find<AuthentictaionRepository>();
  StreamSubscription<AuthenticationState>? _subscription;

  @override
  Future<ApplicationState> init() async {
    _subscription = authenticationRepository.stream.listen(
      (event) {
        emit(
          state
            ..dark = event.dark
            ..isAuthenticated = event.applicant != null,
        );
      },
    );
    return ApplicationState()
      ..dark = authenticationRepository.state.dark
      ..isAuthenticated = authenticationRepository.authenticated;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

class MessengerView extends Feature<ApplicationSpark> {
  const MessengerView({super.key});

  @override
  ApplicationSpark createSpark() => ApplicationSpark();

  @override
  Widget build(context, spark) {
    return MaterialApp(
      navigatorKey: navigator.key,
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
          colors: spark().dark
              ? FThemes.yellow.dark.colors
              : FThemes.green.light.colors,
          typography: FTypography(defaultFontFamily: 'Monaspace Argon'),
        ),
        child: child!,
      ),
      home: spark().isAuthenticated ? MessagesPage() : LoginPage(),
    );
  }

  @override
  Widget error(Object err, st) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text('Error $err'),
          ),
        ),
      ),
    );
  }
}
