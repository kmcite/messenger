import 'package:objectbox/objectbox.dart';

@Entity()
class Message {
  @Id()
  int id = 0;
  String message = '';
  int? senderId;
  DateTime? time;
}
