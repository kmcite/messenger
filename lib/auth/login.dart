import 'package:messenger/auth/register.dart';
import 'package:messenger/auth/auth_state.dart';
import 'package:messenger/navigation/navigator_key.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/ui.dart';

class LoginPage extends AppUI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            TextFormField(
              initialValue: emailSignal(),
              onChanged: emailSignal.set,
            ),
            TextFormField(
              initialValue: passwordSignal(),
              onChanged: passwordSignal.set,
            ),
            ElevatedButton(
              onPressed: () => login(),
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            ElevatedButton(
              onPressed: () => navigateTo(RegisterView()),
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            Text(emailSignal()),
            Text(passwordSignal()),
          ],
        ),
      ),
    );
  }
}
