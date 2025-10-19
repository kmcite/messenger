import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:messenger/auth/register.dart';
import 'package:messenger/features/home/home.dart';
import 'package:messenger/main.dart';

class LoginState {
  final String email;
  final String password;
  String errorMessage = '';

  LoginState(this.email, this.password);

  LoginState copyWith({String? email, String? password}) =>
      LoginState(email ?? this.email, password ?? this.password);
}

class LoginBloc extends Spark<LoginState> {
  late final authenticationRepository = find<AuthentictaionRepository>();
  @override
  Future<LoginState> init() =>
      SynchronousFuture(LoginState('adn@gmail.com', '123456'));

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onLoggedIn() {
    emitAsync(
      () async {
        final response =
            await authenticationRepository.client.applicants.authenticate(
          state.email,
          state.password,
        );

        switch (response) {
          case 0: // 0 applicant not found
            state.errorMessage = 'Applicant not found';
            break;
          case 1: // 1 success authentic
            authenticationRepository.applicant =
                (await authenticationRepository.client.applicants.getByEmail(
              state.email,
            ))!;
            navigator.toRemoveUntil(MessagesPage());
            break;
          case -1: // -1 invalid credentials
            state.errorMessage = 'Invalid credentials';
            break;
          default:
            throw UnknownError();
        }
        return state;
      },
    );
  }
}

class ApplicantNotFound extends Error {
  ApplicantNotFound();
}

class InvalidCredentials extends Error {
  InvalidCredentials();
}

class UnknownError extends Error {
  UnknownError();
}

class LoginPage extends Feature<LoginBloc> {
  @override
  LoginBloc createSpark() => LoginBloc();

  @override
  Widget build(BuildContext context, spark) {
    return FScaffold(
      header: FHeader(
        title: const Text('Login'),
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
            onPress: () => spark.onLoggedIn(),
            child: const Text('Login'),
          ),
          FButton(
            onPress: () => navigator.to(RegisterView()),
            style: FButtonStyle.outline(),
            child: Text('Register'),
          ),
          Text(spark().errorMessage),
        ],
      ),
    );
  }

  @override
  Widget error(Object err, st) {
    if (err is ApplicantNotFound) {
      return ElevatedButton(
        onPressed: () => navigator.to(RegisterView()),
        child: Text('Register'),
      );
    }
    return LoginErrorPage(
      err,
      st,
    );
  }
}

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage(
    this.error,
    this.refresh, {
    super.key,
  });
  final Object error;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Error'),
      ),
      child: Column(
        spacing: 8,
        children: [
          FCard.raw(
            child: Text(error.toString()),
          ),
          FButton(
            child: const Text('Back to Login'),
            onPress: refresh,
          ),
        ],
      ),
    );
  }
}
