import 'package:messenger/main.dart';
import 'package:messenger/users/users_bloc.dart';

class UsersPage extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: context.of<UsersController>().users.length,
        itemBuilder: (context, index) =>
            context.of<UsersController>().users.elementAt(index).text(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.of<UsersController>().createNewUser,
      ),
    );
  }
}
