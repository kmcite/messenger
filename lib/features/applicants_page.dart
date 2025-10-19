import 'package:forui/forui.dart';
import 'package:messenger/auth/create_applicant.dart';
import 'package:messenger/features/home/home.dart';
import 'package:messenger/main.dart';

class ApplicantsSpark extends Spark<List<Applicant>> {
  late final authenticationRepository = find<AuthentictaionRepository>();
  @override
  Future<List<Applicant>> init() async =>
      await authenticationRepository.client.applicants.getAll();
}

class ApplicantsPage extends Feature<ApplicantsSpark> {
  @override
  ApplicantsSpark createSpark() => ApplicantsSpark();

  @override
  Widget build(BuildContext context, spark) {
    return FScaffold(
      header: FHeader(
        title: const Text('Applicants'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.plus),
            onPress: () {
              navigator.toDialog(CreateApplicantDialog());
            },
          ),
          FHeaderAction.x(onPress: navigator.back),
        ],
      ),
      child: RefreshIndicator(
        onRefresh: spark.refresh,
        child: ListView.builder(
          itemCount: spark.state.length,
          itemBuilder: (context, index) {
            final applicant = spark.state.elementAt(index);
            return FTile(
              title: Text(applicant.name),
              subtitle: Text(applicant.email),
              suffix: Icon(FIcons.send),
              onPress: () {
                navigator.to(
                  const MessagesPage(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
