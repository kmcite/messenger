import 'package:forui/forui.dart';
import 'package:messenger/applicants/applicants_state.dart';
import 'package:messenger/applicants/create_applicant.dart';
import 'package:messenger/navigation/navigator_key.dart';
import 'package:messenger/messages/home.dart';
import 'package:messenger/main.dart';
import 'package:messenger/utils/ui.dart';

class ApplicantsPage extends AppUI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Applicants'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.plus),
            onPress: () {
              navigateTo(CreateApplicantDialog());
            },
          ),
          FHeaderAction.x(onPress: navigateBack),
        ],
      ),
      child: ListView.builder(
        itemCount: applicantsSignal.length,
        itemBuilder: (context, index) {
          final applicant = applicantsSignal.elementAt(index);
          return FTile(
            title: Text(applicant.name),
            subtitle: Text(applicant.email),
            suffix: Icon(FIcons.send),
            onPress: () {
              navigateTo(
                const MessagesPage(),
              );
            },
          );
        },
      ),
    );
  }
}
