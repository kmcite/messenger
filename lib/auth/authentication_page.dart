import 'package:messenger/auth/authentication_bloc.dart';
import 'package:messenger/main.dart';
import 'package:messenger/users/users_repository.dart';

class AuthenticationPage extends UI {
  const AuthenticationPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Authentication'.text(),
      ),
      body: ListView(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            initialValue: context.of<AuthenticationBloc>().email,
            onChanged: context.of<AuthenticationBloc>().setEmail,
          ).pad(),
          FilledButton(
            onPressed: context.of<AuthenticationBloc>().isValidEmail
                ? () {
                    context.of<AuthenticationBloc>().login();
                  }
                : null,
            child: 'login'.text(),
          ).pad(),
          ...context.of<UsersRepository>().getAll().map(
            (user) {
              return ListTile(
                title: user.text(),
                onTap: () {
                  context.of<AuthenticationBloc>().loginWith(user);
                },
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
