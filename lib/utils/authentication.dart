// ignore_for_file: invalid_use_of_protected_member

import 'package:manager_client/manager_client.dart';
import 'package:spark/spark.dart';

class AuthenticationState {
  Applicant? applicant;
  bool dark = false;
}

class AuthentictaionRepository extends AliveRepository<AuthenticationState> {
  AuthentictaionRepository() {
    emit(AuthenticationState());
  }
  late final Client client = serve<Client>();
  String get serverIp => client.host;
  bool get authenticated => state.applicant != null;

  Applicant get applicant => state.applicant!;
  void set applicant(Applicant applicant) {
    emit(state..applicant = applicant);
  }

  Future<void> setDark(bool dark) async {
    await emitAsync(() async => state..dark = dark);
  }

  Future<void> logout() async {
    await emitAsync(() async => state..applicant = null);
  }
}
