import 'package:messenger/main.dart';
import 'package:messenger/navigator.dart';
import 'package:messenger/users/users_repository.dart';

import '../objectbox.g.dart';

class AuthenticationRepository {
  User? _user;
  User? get user => _user;
  void setUser(User) {
    _user = User;
  }
}

class AuthenticationBloc extends ChangeNotifier {
  /// DEPENDENCIES
  UsersRepository get _usersRepository => _context.of();
  NavigationRepository get _navigationRepository => _context.of();
  AuthenticationRepository get _authenticationRepository => _context.of();
  BuildContext _context;
  AuthenticationBloc(this._context) {
    _user = _authenticationRepository.user;
  }

  User? _user;
  User get user => _user ?? User();
  bool get isAuthenticated => _user != null;

  bool get isValidEmail => email.isNotEmpty && email.contains('@');
  String email = 'adn@gmail.com';
  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
    _navigationRepository.logoutHappened();
  }

  void delete() {
    _usersRepository.remove(user.id);
    logout();
  }

  _create(User user) {
    _user = user;
    _usersRepository.put(user);
  }

  void login() {
    final any =
        _usersRepository.query(User_.email.equals(email)).build().findFirst();
    if (any != null) {
      _user = any;
    } else {
      final newUser = User()..email = email;
      _create(newUser);
    }
    _navigationRepository.loginHappened();
    notifyListeners();
  }

  void loginWith(User user) {
    _user = user;
    notifyListeners();
    _navigationRepository.loginHappened();
  }
}
