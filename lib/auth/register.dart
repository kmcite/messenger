import 'package:messenger/auth/auth_state.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/ui.dart';

class RegisterView extends AppUI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
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
                child: const Text('Register'),
                onPressed: () => register(),
              ),
            ],
          ),
        ));
  }
}
