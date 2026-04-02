import 'package:objectbox/objectbox.dart';

@Entity()
class Applicant {
  @Id()
  int id = 0;
  String name = '';
  String email = '';
}
