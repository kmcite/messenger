import 'package:forui/forui.dart';
import 'package:messenger/main.dart';

class ApplicantsRow extends StatelessWidget {
  const ApplicantsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        FAvatar.raw(),
        FAvatar.raw(),
        FAvatar.raw(),
      ],
    );
  }
}
