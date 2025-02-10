import 'package:messenger/auth/authentication_page.dart';
import 'package:messenger/main.dart';

class NavigationController extends ChangeNotifier {
  NavigationRepository get _repository => _context.of();
  NavigationController(this._context);
  BuildContext _context;
  GlobalKey<NavigatorState> get key => _repository.key;
  void back<T extends Object?>([T? result]) => key.currentState!.pop();

  Future<T?> to<T extends Object?>(Widget page) async {
    return await key.currentState!.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> dialog<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) {
    return showDialog(
      context: key.currentContext!,
      builder: (context) => dialog,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
    );
  }
}

class NavigationRepository {
  BuildContext get context => key.currentContext!;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  void logoutHappened() => key.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => AuthenticationPage()),
        (route) => false,
      );

  void loginHappened() => key.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatsPage()),
        (route) => false,
      );
}
