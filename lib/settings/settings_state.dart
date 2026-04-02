import 'package:signals/signals.dart';

final darkSignal = signal<bool>(false);
void toggleDark() => darkSignal.value = !darkSignal.value;
