import 'package:forui/forui.dart';
import 'package:messenger/main.dart';

class CreateApplicantSpark extends Spark<Applicant> {
  @override
  Future<Applicant> init() async {
    return Applicant();
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }
}

class CreateApplicantDialog extends Feature<CreateApplicantSpark> {
  const CreateApplicantDialog({super.key});

  @override
  CreateApplicantSpark createSpark() => CreateApplicantSpark();

  @override
  Widget build(BuildContext context, spark) {
    return FDialog(
      title: const Text('CREATE CONTACT'),
      direction: Axis.horizontal,
      body: Column(
        children: [
          FTextField(
            label: const Text('Name'),
            initialText: spark.state.name,
            onChange: (value) => spark.onNameChanged(value),
          ),
          FTextField.email(
            initialText: spark.state.email,
            onChange: (value) => spark.onEmailChanged(value),
          ),
          FTextField.password(
            initialText: spark.state.password,
            onChange: (value) => spark.onPasswordChanged(value),
          ),
          Text(spark.state.password),
        ],
      ),
      actions: [
        FButton(
          child: const Text('Okay'),
          onPress: spark.state.password.isEmpty
              ? null
              : () {
                  navigator.back();
                },
        ),
        FButton(
          child: const Text('Cancel'),
          onPress: () {
            navigator.back();
          },
        ),
      ],
    );
  }
}
