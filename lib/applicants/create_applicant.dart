import 'package:forui/forui.dart';
import 'package:messenger/auth/auth_state.dart';
import 'package:messenger/navigation/navigator_key.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/ui.dart';

class CreateApplicantDialog extends AppUI {
  const CreateApplicantDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: const Text('CREATE CONTACT'),
      direction: Axis.horizontal,
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            initialValue: nameSignal(),
            onChanged: nameSignal.set,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            initialValue: emailSignal(),
            onChanged: emailSignal.set,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            initialValue: passwordSignal(),
            onChanged: passwordSignal.set,
          ),
          Text(passwordSignal()),
        ],
      ),
      actions: [
        FButton(
          child: const Text('Okay'),
          onPress: passwordSignal().isEmpty ? null : () => navigateBack(),
        ),
        FButton(
          child: const Text('Cancel'),
          onPress: () => navigateBack(),
        ),
      ],
    );
  }
}
