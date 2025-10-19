import 'package:forui/forui.dart';
import 'package:messenger/auth/login.dart';
import 'package:messenger/features/home/home.dart';
import 'package:messenger/main.dart';

class RegisterState {
  String email = 'adn@gmail.com';
  String password = '123456';
}

class RegisterBloc extends Spark<RegisterState> {
  late final authenticationRepository = find<AuthentictaionRepository>();
  @override
  Future<RegisterState> init() async {
    return RegisterState();
  }

  void onEmailChanged(String email) {
    emit(state..email = email);
  }

  void onPasswordChanged(String password) {
    emit(state..password = password);
  }

  void onRegister() {
    stateAsync = Future.delayed(
      Duration(seconds: 1),
      () async {
        final response =
            await authenticationRepository.client.applicants.insert(Applicant(
          email: state.email,
          password: state.password,
        ));
        if (response) {
          navigator.to(MessagesPage());
        } else {
          navigator.to(LoginPage());
        }
        return state;
      },
    );
  }
}

class RegisterView extends Feature<RegisterBloc> {
  @override
  RegisterBloc createSpark() => RegisterBloc();

  @override
  Widget build(BuildContext context, spark) {
    return FScaffold(
      header: FHeader(
        title: const Text('Register'),
      ),
      child: Column(
        spacing: 8,
        children: [
          FTextField.email(
            initialText: spark().email,
            onChange: spark.onEmailChanged,
          ),
          FTextField.password(
            initialText: spark().password,
            onChange: spark.onPasswordChanged,
          ),
          FButton(
            child: const Text('Register'),
            onPress: () => spark.onRegister(),
          ),
        ],
      ),
    );
  }

  @override
  Widget loading(BuildContext context) {
    return FScaffold(child: FCircularProgress.pinwheel());
  }

  @override
  Widget error(error, refresh) {
    return FScaffold(
      header: FHeader(
        title: const Text('Error'),
      ),
      child: Center(
        child: FButton(child: Text('$error'), onPress: refresh),
      ),
    );
  }
}
